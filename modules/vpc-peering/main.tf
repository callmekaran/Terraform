resource "aws_vpc_peering_connection" "vpc-1to-vpc2-peering-connection" {
  vpc_id        = var.refrence-vpc1-id
  peer_vpc_id   = var.refrence-vpc2-id
  auto_accept   = true

  tags = {
    Name = "vpc-1to-vpc2-peering-connection"
  }

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

}

resource "aws_route" "vpc1-to-vpc2-peering-route" {
  route_table_id         = var.refrence-vpc1-rt-id
  destination_cidr_block = "172.158.1.0/24"  # CIDR block of VPC2
  vpc_peering_connection_id = var.refrence-vpc-peering-connection-id
}

resource "aws_route" "vpc2-to-vpc1-peering-route" {
  route_table_id         = var.refrence-vpc2-rt-id
  destination_cidr_block = "192.168.1.0/24"  # CIDR block of VPC2
  vpc_peering_connection_id = var.refrence-vpc-peering-connection-id
}
