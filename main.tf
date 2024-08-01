module "ssm-parameter" {
    source = "./modules/ssm"
}
module "sns-topic-creation" {
    source = "./modules/sns"
    email_addresses = var.email_addresses
    reference_sns_topic = module.sns-topic-creation.sns_topic_arn

}
module "staging-server-ec2" {
    source = "./modules/ec2"
    instance_id         = module.staging-server-ec2.instance_id
}
module "cloudwatch" {
  source = "./modules/cloudwatch"
  reference_sns_topic = module.sns-topic-creation.sns_topic_arn
  instance_id         = module.staging-server-ec2.instance_id
  depends_on = [ module.staging-server-ec2 ]
}
