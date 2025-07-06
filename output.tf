output "repository_url" {
  value = aws_ecr_repository.nginx.repository_url
}

output "load_balancer_url" {
  value = aws_lb.alb.dns_name
}
