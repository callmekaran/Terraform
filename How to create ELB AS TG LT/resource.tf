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
    type = "redirect"
    redirect {
      protocol    = "HTTPS"
      port        = "443"
      status_code = "HTTP_301"
    }
  }
}
resource "aws_launch_template" "launch_template" {
  name          = "my-launch-template"
  image_id      = "ami-03bb6d83c60fc5f7c"
  instance_type = var.instance_type

  network_interfaces {
    device_index    = 0
    subnet_id       = data.aws_subnet.ap-south-1a_subnets.id
    security_groups = [data.aws_security_group.asg_security_group.id]
  }

  network_interfaces {
    device_index    = 1
    subnet_id       = data.aws_subnet.ap-south-1b_subnets.id
    security_groups = [data.aws_security_group.asg_security_group.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "my-instance"
    }
  }
}
resource "aws_autoscaling_group" "auto_scaling_group" {
  name              = "my-auto-scaling-group"
  desired_capacity  = var.desired_capacity
  max_size          = var.max_size
  min_size          = var.min_size
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
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"  // You may adjust the SSL policy according to your requirements
  certificate_arn   = data.aws_acm_certificate.cert.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}

