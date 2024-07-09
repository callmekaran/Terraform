module "vpc" {
  source                    = "./modules/vpc"
  public_subnet_cidr_block  = var.public_subnet_cidr_block
  vpc_tags                  = var.vpc_tags
  public_subnet_tags        = var.public_subnet_tags
  igw_tags                  = var.igw_tags
  route_cidr_block          = var.route_cidr_block
  public_route_tags         = var.public_route_tags
  vpc_cidr_block            = var.vpc_cidr_block
  private_route_tags        = var.private_route_tags
  private_subnet_cidr_block = var.private_subnet_cidr_block
  private_subnet_tags       = var.private_subnet_tags

}

module "ec2" {
  source           = "./modules/ec2"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
}
