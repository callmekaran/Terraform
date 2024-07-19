output "launch_template_id" {
  value = module.launch_template.launch_template_id
}
output "asg_arn" {
  value = module.autoscaling.asg_arn
}
output "aws_ecs_policy" {
  value = module.ecs_policy.aws_ecs_policy
}