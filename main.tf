module "secret_manager" {
  source = "./modules/secret-manager"
  reference_secret_manager = module.secret_manager.secret_arn
}


module "iam" {
  source = "./modules/iam"
  depends_on = [ module.secret_manager ]
  reference_secret_manager = module.secret_manager.secret_arn

}

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
