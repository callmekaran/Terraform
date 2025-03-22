data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = [ "ubuntu/images/hvm-ssd-gp3/ubuntu*24.04*" ]
  }

  owners = [ "amazon" ]
}
