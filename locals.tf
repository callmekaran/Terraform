locals {
  cluster_name = "nginx-cluster"
}

locals {
  ecs_task_assume_role_policy = {
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  }
}

locals {
  ecr_repo_name = "nginx"
}


locals {
  container_definitions = [
    {
      name      = "nginx"
      image = "${aws_ecr_repository.nginx.repository_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
        logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/nginx-task"
          awslogs-region        = "ap-south-1"
          awslogs-stream-prefix = "ecs"
        }
      }

    }
  ]
}
