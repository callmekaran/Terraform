resource "aws_vpc" "vpc1" {
  cidr_block           = var.vpc1-cidr-block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc1"
  }
}


resource "aws_subnet" "vpc1-public-subet" {
  cidr_block = var.vpc1-public-subnet-cidr-block
  vpc_id     = aws_vpc.vpc1.id
  tags = {
    Name = "vpc1-public-subnet"
  }

}

resource "aws_subnet" "vpc1-private-subet" {
  cidr_block = var.vpc1-private-subnet-cidr-block
  vpc_id     = aws_vpc.vpc1.id
  tags = {
    Name = "vpc1-private-subnet"
  }

}

resource "aws_internet_gateway" "vpc1-internet_gateway" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "vpc1-internet_gateway"
  }
}


resource "aws_route_table" "vpc1-public-route-table" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc1-internet_gateway.id
  }

  tags = {
    Name = "vpc1-public-route-table"
  }
}

resource "aws_route_table_association" "vpc1-public-route-table-association" {
  subnet_id      = aws_subnet.vpc1-public-subet.id
  route_table_id = aws_route_table.vpc1-public-route-table.id
}

resource "aws_route_table" "vpc1-private-route-table" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "vpc1-private-route-table"
  }
}

resource "aws_route_table_association" "vpc1-private-route-table-association" {
  subnet_id      = aws_subnet.vpc1-private-subet.id
  route_table_id = aws_route_table.vpc1-private-route-table.id
}

