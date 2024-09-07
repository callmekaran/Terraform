provider "aws" {
  profile = "personal"
}

module "secret_manager" {
    source = "./modules/secret-manager"
}

terraform {
  backend "s3" {
    profile = "personal"
    bucket  = "karan7990539526"
    key     = "dev/terraform.tfstate"
    region  = "us-east-1"
  }

}

