output "vpc2-id" {
  value = module.vpc2.vpc2-id
}

output "vpc1-id" {
  value = module.vpc1.vpc1-id
}

output "vpc1-route-table-id" {
  value = module.vpc1.vpc1-route-table-id
}

output "vpc2-route-table-id" {
  value = module.vpc2.vpc2-route-table-id
}

output "vpc-peering-connection-id" {
  value = module.vpc-peerings.vpc-peering-connection-id
}


output "vpc1-public-subnet-cidr-block" {
  value = module.vpc1.vpc1-public-subnet-cidr-block
}


output "vpc2-public-subnet-cidr-block" {
  value = module.vpc2.vpc2-public-subnet-cidr-block
}
