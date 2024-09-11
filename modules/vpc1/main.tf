resource "aws_vpc" "vpc1" {
    cidr_block = "192.168.0.0/16"
    enable_dns_support = true    # Enables DNS support for the VPC
    enable_dns_hostnames = true  # Enables DNS hostnames for the VPC

    

    tags = {
    Name = "vpc1"
  }
}

resource "aws_subnet" "vpc1-public-subet" {
    cidr_block = "192.168.1.0/24"
    vpc_id = aws_vpc.vpc1.id
    tags = {
      Name = "vpc2-public-subnet"
    }
  
}

resource "aws_subnet" "vpc1-private-subet" {
    cidr_block = "192.168.2.0/24"
    vpc_id = aws_vpc.vpc1.id
    tags = {
      Name = "vpc2-private-subnet"
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

