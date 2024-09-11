output "vpc2-id" {
    value = aws_vpc.vpc2.id
}

output "vpc2-route-table-id" {
  value = aws_route_table.vpc2-public-route-table.id
}
