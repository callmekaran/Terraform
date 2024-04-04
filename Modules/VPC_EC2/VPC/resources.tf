resource "aws_vpc" "discusit-vpc" {
  cidr_block       = var.vpc_cidr_block

  tags = {
    Name = var.vpc_tags
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.discusit-vpc.id
  cidr_block = var.public_subnet_cidr_block

  tags = {
    Name = var.public_subnet_tags
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.discusit-vpc.id
  cidr_block = var.private_subnet_cidr_block

  tags = {
    Name = var.private_subnet_tags
  }
}

resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.discusit-vpc.id


  tags = {
    Name = var.private_route_tags
  }
}
resource "aws_route_table_association" "private-a" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-route.id
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.discusit-vpc.id

  tags = {
    Name = var.igw_tags
  }
}
resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.discusit-vpc.id

  route {
    cidr_block = var.route_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.public_route_tags
  }
}
resource "aws_route_table_association" "public-a" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-route.id
}
