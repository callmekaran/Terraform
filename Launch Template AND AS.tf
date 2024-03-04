provider "aws" {
  region = "ap-south-1"
  access_key  = ""AA
  secret_key = "N4Q"
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  
    filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

variable "instance_type" {
  default = "t2.micro"
}

variable "desired_capacity" {
  default = 2
}

variable "max_size" {
  default = 3
}

variable "min_size" {
  default = 1
}

data "aws_security_group" "asg_security_group" {
  name = "launch-wizard-7"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "ap-south-1a_subnets" {
  vpc_id = data.aws_vpc.default.id

  tags = {
    az = "ap-south-1a"
  }
}

data "aws_subnet" "ap-south-1b_subnets" {
  vpc_id = data.aws_vpc.default.id

  tags = {
    az = "ap-south-1b"
  }
}

resource "aws_lb_target_group" "my_target_group" {
  name        = "my-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.default.id

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
  stickiness {provider "aws" {
  region = "ap-south-1"
  access_key  = "AKIAQ3EGT6YYRACLT5XJ"
  secret_key = "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"
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  
    filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

variable "instance_type" {
  default = "t2.micro"
}

variable "desired_capacity" {
  default = 2
}

variable "max_size" {
  default = 3
}

variable "min_size" {
  default = 1
}

data "aws_security_group" "asg_security_group" {
  name = "launch-wizard-7"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "ap-south-1a_subnets" {
  vpc_id = data.aws_vpc.default.id

  tags = {
    az = "ap-south-1a"
  }
}

data "aws_subnet" "ap-south-1b_subnets" {
  vpc_id = data.aws_vpc.default.id

  tags = {
    az = "ap-south-1b"
  }
}

resource "aws_lb_target_group" "my_target_group" {
  name        = "my-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.default.id

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
    type            = "lb_cookie"
    cookie_duration = 300
  }

  // Tags (optional)
  tags = {
    Name = "MyTargetGroup"
  }
}

resource "aws_launch_template" "launch_template" {
  name          = "my-launch-template"
  image_id      = "ami-03bb6d83c60fc5f7c"
  instance_type = var.instance_type

  network_interfaces {
    device_index    = 0provider "aws" {
  region = "ap-south-1"
  access_key  = "AKIAQ3EGT6YYRACLT5XJ"
  secret_key = "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"
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  
    filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

variable "instance_type" {
  default = "t2.micro"
}

variable "desired_capacity" {
  default = 2
}

variable "max_size" {
  default = 3
}

variable "min_size" {
  default = 1
}

data "aws_security_group" "asg_security_group" {
  name = "launch-wizard-7"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "ap-south-1a_subnets" {
  vpc_id = data.aws_vpc.default.id

  tags = {
    az = "ap-south-1a"
  }
}

data "aws_subnet" "ap-south-1b_subnets" {
  vpc_id = data.aws_vpc.default.id

  tags = {
    az = "ap-south-1b"
  }
}

resource "aws_lb_target_group" "my_target_group" {
  name        = "my-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.default.id

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
    type            = "lb_cookie"
    cookie_duration = 300
  }

  // Tags (optional)
  tags = {
    Name = "MyTargetGroup"
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
  name             = "my-auto-scaling-group"
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size
  target_group_arns   = [aws_lb_target_group.my_target_group.arn]
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }
}

resource "aws_autoscaling_policy" "cpu_scaling_policy" {
  name                   = "cpu-scaling-policy"
  scaling_adjustment     = 1  // Increase desired capacity by 1 instance
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300 // 5 minutes cooldown period
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.name

  // Specify the metric alarm
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
      target_value           = 70
    }
    disable_scale_in = false // Allow scaling in
  }
}
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
  name             = "my-auto-scaling-group"
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size
  target_group_arns   = [aws_lb_target_group.my_target_group.arn]
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }
}

resource "aws_autoscaling_policy" "cpu_scaling_policy" {
  name                   = "cpu-scaling-policy"
  scaling_adjustment     = 1  // Increase desired capacity by 1 instance
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300 // 5 minutes cooldown period
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.name

  // Specify the metric alarm
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
      target_value           = 70
    }
    disable_scale_in = false // Allow scaling in
  }
}
    type            = "lb_cookie"
    cookie_duration = 300
  }

  // Tags (optional)
  tags = {
    Name = "MyTargetGroup"
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
  name             = "my-auto-scaling-group"
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size
  target_group_arns   = [aws_lb_target_group.my_target_group.arn]
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }
}

resource "aws_autoscaling_policy" "cpu_scaling_policy" {
  name                   = "cpu-scaling-policy"
  scaling_adjustment     = 1  // Increase desired capacity by 1 instance
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300 // 5 minutes cooldown period
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.name

  // Specify the metric alarm
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
      target_value           = 70
    }
    disable_scale_in = false // Allow scaling in
  }
}
