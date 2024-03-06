resource "aws_lb_target_group" "my_target_group" {
  name        = "my-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.default.id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 10
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  stickiness {
    type            = "lb_cookie"
    cookie_duration = 300
  }

  tags = {
    Name = "MyTargetGroup"
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Allow inbound HTTP and HTTPS traffic"

  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets = concat(
    data.aws_subnet.ap-south-1a_subnets[*].id,
    data.aws_subnet.ap-south-1b_subnets[*].id
  )

  enable_deletion_protection = false # Change to true to enable deletion protection
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = "80"
  protocol          = "HTTP"
   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.my_target_group.arn}"
  }
}
resource "aws_launch_template" "launch_template" {
  name          = "my-launch-template"
  image_id      = "ami-03bb6d83c60fc5f7c"
  instance_type = var.instance_type
  key_name      = "karan"  # Replace with the name of your key pair
  vpc_security_group_ids = [aws_security_group.alb_sg.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "my-instance"
    }
  }
  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y nginx
              public_ip=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
              sudo echo "Hello from Nginx $public_ip" > /var/www/html/index.nginx-debian.html
              sudo systemctl restart nginx
              sudo systemctl enable nginx
              EOF
)
}

resource "aws_autoscaling_group" "auto_scaling_group" {
  name             = "my-auto-scaling-group"
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size

  # Specify the subnet IDs where instances will be launched
  vpc_zone_identifier = [
    data.aws_subnet.ap-south-1a_subnets.id,
    data.aws_subnet.ap-south-1b_subnets.id
  ]

  target_group_arns = [aws_lb_target_group.my_target_group.arn]
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }
}

resource "aws_autoscaling_policy" "cpu_scaling_policy" {

  name                   = "cpu-scaling-policy"
  policy_type            = "TargetTrackingScaling" // Specify the policy type
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.name

  // Specify the metric alarm
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value     = 70
    disable_scale_in = false // Allow scaling in
  }
}
