instance_type             = "t2.micro"
launch_template_id_source = "module.launch_template.launch_template_id"
auto_scaling_arn = "module.auto_scaling.asg.arn"
aws_ecs_policy = "module.ecs_policy.aws_ecs_policy.name"