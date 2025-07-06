resource "aws_ecr_repository" "nginx" {
  name                 = local.ecr_repo_name
  image_tag_mutability = "MUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }
}


#Lets Create 1st Cluster, You don`t need to meintion Farget Here in cluster defination as it will be in Task defination

resource "aws_ecs_cluster" "nginx-cluster" {
  name = local.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = jsonencode(local.ecs_task_assume_role_policy)
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}



resource "aws_ecs_task_definition" "app" {
  family                   = "nginx"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode(local.container_definitions)
}



resource "aws_ecs_service" "nginx-service" {
  name            = "nginx-service"
  cluster         = aws_ecs_cluster.nginx-cluster.id
  task_definition = aws_ecs_task_definition.app.id
  desired_count   = 1 
  launch_type     = "FARGATE"
  network_configuration {
  subnets = [for subnet in aws_default_subnet.default : subnet.id]
  assign_public_ip = true
    security_groups    = [aws_security_group.alb_security_group.id]

  }

  load_balancer {
    target_group_arn = aws_lb_target_group.nginx_ecs.arn
    container_name   = "nginx"
    container_port   = 80
  }
}

resource "aws_ecs_cluster_capacity_providers" "example" {
  cluster_name = aws_ecs_cluster.nginx-cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/nginx-task"
  retention_in_days = 7  # Or whatever is appropriate
}


resource "aws_appautoscaling_target" "ecs_service" {
  max_capacity       = 2
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.nginx-cluster.name}/${aws_ecs_service.nginx-service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "cpu_scale_up" {
  name               = "cpu-scale-up"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_service.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_service.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_service.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 10.0
    scale_in_cooldown  = 60
    scale_out_cooldown = 60
  }
}
