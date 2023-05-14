provider "aws" {
  region     = "ap-south-1"
  access_key = "ANA"
  secret_key = "NAA/Z2jD0sYm"
}
resource "aws_vpc" "discusit-vpc" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}
resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.discusit-vpc.id
  cidr_block = "192.168.1.0/24"

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.discusit-vpc.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.discusit-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "example"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-route.id
}
