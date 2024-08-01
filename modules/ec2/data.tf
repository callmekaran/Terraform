data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}
data "aws_vpc" "default" {
  default = true
}
data "aws_iam_role" "ssm_role" {
  name = "SSM"  # Replace with your actual role name
}
data "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "SSM"  # Replace with your actual instance profile name
}
