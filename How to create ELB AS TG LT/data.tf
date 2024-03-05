
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

data "aws_security_group" "asg_security_group" {
  name = "launch-wizard-7" # Replace with the actual name of your security group
}

data "aws_acm_certificate" "cert" {
  domain   = "example.com" // Replace with your actual domain
  statuses = ["ISSUED"]
}
