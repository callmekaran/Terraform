provider "aws" {
  region = "ap-south-1"
  access_key  = "####################3"
  secret_key = "######################3"
# Chang this to your desired AWS region
}
data "aws_vpc" "default" {
  default = true
}


resource "aws_lb_target_group" "my_target_group" {
  name                      = "my-target-group"
  port                      = 80
  protocol                  = "HTTP"
  target_type               = "instance"
  vpc_id                    = data.aws_vpc.default.id

  // Health check settings
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

  // Stickiness settings
  stickiness {
    type                = "lb_cookie"  # You can choose "lb_cookie" or "source_ip" as the stickiness type. i have use load balancer generated cookie
    cookie_duration     = 300
  }

  // Tags (optional)
  tags = {
    Name = "MyTargetGroup"
  }
}
