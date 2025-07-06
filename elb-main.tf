resource "aws_security_group" "alb_security_group" {
  name_prefix = "alb-security-group"
  description = "Security group for Application Load Balancer"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
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

# ALB (Application Load Balancer)
resource "aws_lb" "alb" {
  name               = "nginx-alb"
  internal           = false
  load_balancer_type = "application"
  subnets = [for subnet in aws_default_subnet.default : subnet.id]
  security_groups    = [aws_security_group.alb_security_group.id]
}

resource "aws_default_vpc" "default" {}


resource "aws_default_subnet" "default" {
  for_each = toset(["ap-south-1a", "ap-south-1b", "ap-south-1c"])

  availability_zone = each.value
}



# ALB listener for HTTPS
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_ecs.arn
  }
}

# ALB target group
resource "aws_lb_target_group" "nginx_ecs" {
  name        = "nginx-ecs-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_default_vpc.default.id
}
