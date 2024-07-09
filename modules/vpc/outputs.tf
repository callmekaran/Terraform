output "vpc_id" {
  value = aws_vpc.discusit-vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public-subnet.id
}

