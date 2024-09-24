output "sns_topic_arn" {
  value = module.sns-topic-creation.sns_topic_arn
}
output "instance_id" {
    value = module.staging-server-ec2.instance_id
}
