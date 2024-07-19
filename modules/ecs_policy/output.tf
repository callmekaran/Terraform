output "aws_ecs_policy" {
  value = aws_iam_instance_profile.ecs_instance_profile.name
}