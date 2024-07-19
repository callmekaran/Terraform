resource "aws_key_pair" "karan" {
  key_name   = var.key_name
  public_key = file("${path.module}/my-kwy.pub")
}

resource "aws_launch_template" "launch_template" {
  name          = "my-launch-template"
  image_id      = data.aws_ami.ubuntu.image_id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [data.aws_security_group.sg.id]

  iam_instance_profile {
    name = var.aws_ecs_policy
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "my-instance"
    }
  }
  user_data = base64encode(<<EOF
#!/bin/bash 
echo ECS_CLUSTER=my-cluster >> /etc/ecs/ecs.config;
EOF
  )
}
