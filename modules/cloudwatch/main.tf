# CloudWatch alarm for CPU utilization

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

# CloudWatch alarm for EC2 instance status check
resource "aws_cloudwatch_metric_alarm" "instance_status_check_alarm" {
  alarm_name          = "InstanceStatusCheckFailure-${var.instance_id}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "StatusCheckFailed_Instance"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Maximum"
  threshold           = 0
  alarm_description   = "This metric monitors the instance status check failures"
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

# CloudWatch alarm for system status check
resource "aws_cloudwatch_metric_alarm" "system_status_check_alarm" {
  alarm_name          = "SystemStatusCheckFailure-${var.instance_id}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "StatusCheckFailed_System"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Maximum"
  threshold           = 0
  alarm_description   = "This metric monitors the system status check failures"
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
