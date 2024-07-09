provider "aws" {
  region  = "ap-south-1"
  profile = "personal"

}

terraform {
  backend "s3" {
    profile = "personal"
    bucket  = "rrrlogical-techsoft-pvt"
    key     = "dev/terraform.tfstate"
    region  = "ap-south-1"
  }

}
