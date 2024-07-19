provider "aws" {
  region  = "us-east-1"
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

module "ecs_policy" {
  source = "./modules/ecs_policy"
  aws_ecs_policy = module.ecs_policy.aws_ecs_policy
}


module "launch_template" {
  source                    = "./modules/launch_template"
  instance_type             = var.instance_type
  key_name                  = var.key_name
  launch_template_id_source = module.launch_template.launch_template_id
  aws_ecs_policy = module.ecs_policy.aws_ecs_policy
}


module "autoscaling" {
  source                    = "./modules/auto_scaling"
  launch_template_id_source = module.launch_template.launch_template_id
  auto_scaling_arn = module.autoscaling.asg_arn
}

module "ecs" {
  source = "./modules/ecs_cluster"
  auto_scaling_arn = module.autoscaling.asg_arn
}
