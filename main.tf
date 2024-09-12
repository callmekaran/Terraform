terraform {
  backend "s3" {
    profile = "personal"
    bucket  = "karan7990539526"
    key     = "dev/terraform.tfstate"
    region  = "us-east-1"
  }

}
provider "aws" {
  profile = "personal"
}

module "vpc1" {
  source                                 = "./modules/vpc1"
  refrence-vpc1-id                       = module.vpc1.vpc1-id
  refrence-vpc1-rt-id                    = module.vpc1.vpc1-route-table-id
  refrence-vpc1-public-subnet-cidr-block = module.vpc1.vpc1-public-subnet-cidr-block

}

module "vpc2" {
  source                                 = "./modules/vpc2"
  refrence-vpc2-id                       = module.vpc2.vpc2-id
  refrence-vpc2-rt-id                    = module.vpc2.vpc2-route-table-id
  refrence-vpc2-public-subnet-cidr-block = module.vpc2.vpc2-public-subnet-cidr-block
}

module "vpc-peerings" {
  source                                 = "./modules/vpc-peering"
  refrence-vpc1-id                       = module.vpc1.vpc1-id
  refrence-vpc2-id                       = module.vpc2.vpc2-id
  refrence-vpc-peering-connection-id     = module.vpc-peerings.vpc-peering-connection-id
  refrence-vpc1-rt-id                    = module.vpc1.vpc1-route-table-id
  refrence-vpc2-rt-id                    = module.vpc2.vpc2-route-table-id
  refrence-vpc1-public-subnet-cidr-block = module.vpc1.vpc1-public-subnet-cidr-block
  refrence-vpc2-public-subnet-cidr-block = module.vpc2.vpc2-public-subnet-cidr-block
}
