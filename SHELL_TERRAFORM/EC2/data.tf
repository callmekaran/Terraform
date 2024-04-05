data "aws_vpc" "discusit" {
  tags = {
    Name = "discusit"
  }
}

# Retrieve data for the public subnet within the specified VPC
data "aws_subnet" "public_subnet" {
  vpc_id = data.aws_vpc.discusit.id  # Use the ID of the VPC named "discusit"

  # Filter the subnet by its tag named "Name" with value "public-subnet"
  filter {
    name   = "tag:Name"
    values = ["public-subnet"]
  }
}
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
