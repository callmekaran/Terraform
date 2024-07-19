resource "aws_ecs_cluster" "my_ecs" {
  name = "my-cluster"
}

resource "aws_ecs_cluster_capacity_providers" "example" {
  cluster_name        = aws_ecs_cluster.my_ecs.name
  capacity_providers  = [aws_ecs_capacity_provider.test.name]
  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.test.name
  }
}


resource "aws_ecs_capacity_provider" "test" {
  name = "test"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = var.auto_scaling_arn
    managed_scaling {
      status                    = "ENABLED"
    }
  }
}

resource "aws_ecs_task_definition" "ecs_task_defination" {
  family = "service"
  network_mode = "bridge"
  requires_compatibilities = ["EC2"]
  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "nginx"
      cpu       = 500
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    },

  ])
}

resource "aws_ecs_service" "service" {
  name            = "nginx-service"
  cluster         = aws_ecs_cluster.my_ecs.id
  task_definition = aws_ecs_task_definition.ecs_task_defination.arn
  desired_count   = 1
  launch_type     = "EC2"

  
  deployment_controller {
    type = "ECS"
  }

  depends_on = [
    aws_ecs_task_definition.ecs_task_defination,
    aws_ecs_cluster.my_ecs
  ]
}