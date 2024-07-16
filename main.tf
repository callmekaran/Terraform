provider "aws" {
    region = "us-east-1"
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

module "s3" {
  source = "./modules/s3"
  bucketname = var.bucketname
  domain_name = var.domain_name
  cloudfront_arn = module.cloudfront.cloudfront_distribution_arn
}

module "acm" {
  source = "./modules/acm"
  domain_name = var.domain_name
}


module "cloudfront" {
  source             = "./modules/cloudfront"
  domain_name        = var.domain_name
  acm_certificate_arn = module.acm.certificate_arn
  bucket_domain_name  = module.s3.bucket_domain_name
  cloudfront_arn = module.cloudfront.cloudfront_distribution_arn
}