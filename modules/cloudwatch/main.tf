resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "Server Name - Ubuntu22Server, HighCPUUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors the CPU utilization"
  actions_enabled     = true
  alarm_actions       = [var.reference_sns_topic]
  ok_actions          = [var.reference_sns_topic] 

  dimensions = {
    InstanceId = var.instance_id
  }

  tags = {
    environment = "production"
  }
}

# CloudWatch alarm for Memory utilization
resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
  alarm_name          = "Server Name - Ubuntu22Server, HighMemoryUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent" # CloudWatch agent namespace
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors the memory utilization"
  actions_enabled     = true
  alarm_actions       = [var.reference_sns_topic]
  ok_actions          = [var.reference_sns_topic] 

  dimensions = {
    InstanceId = var.instance_id
  }

  tags = {
    environment = "production"
  }
}

# CloudWatch alarm for Disk utilization
resource "aws_cloudwatch_metric_alarm" "disk_alarm" {
  alarm_name          = "Server Name - Ubuntu22Server, HighDiskUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent" # CloudWatch agent namespace
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors the disk utilization"
  actions_enabled     = true
  alarm_actions       = [var.reference_sns_topic]
  ok_actions          = [var.reference_sns_topic] 

  dimensions = {
    InstanceId = var.instance_id
    path = "/"
    fstype = "ext4"
    device = "nvme0n1p1"
  }

  tags = {
    environment = "production"
  }
}
