provider "aws" {
  profile = "personal"
  region = "us-east-1"

}

terraform {
  backend "s3" {
    profile = "personal"
    bucket  = "karan7990539526"
    key     = "dev/terraform.tfstate"
    region  = "us-east-1"
  }

}
