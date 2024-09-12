output "vpc1-id" {
  value = aws_vpc.vpc1.id
}

output "vpc1-route-table-id" {
  value = aws_route_table.vpc1-public-route-table.id
}

output "vpc1-public-subnet-cidr-block" {
  value = aws_subnet.vpc1-public-subet.cidr_block
}

