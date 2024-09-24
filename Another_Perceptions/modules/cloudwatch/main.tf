resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  for_each = toset(var.instance_id)  # Use for_each to loop over instance IDs

  alarm_name          = "CPUUtilization-${each.key}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors the CPU utilization for instance ${each.key}"
  actions_enabled     = true
  alarm_actions       = [var.reference_sns_topic]
  ok_actions          = [var.reference_sns_topic]

  dimensions = {
    InstanceId = each.key  # Use each.key to get the current instance ID
  }

  tags = {
    environment = "production"
  }
}

resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
  for_each = toset(var.instance_id)

  alarm_name          = "MemoryUtilization-${each.key}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent" # CloudWatch agent namespace
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors the memory utilization for instance ${each.key}"
  actions_enabled     = true
  alarm_actions       = [var.reference_sns_topic]
  ok_actions          = [var.reference_sns_topic]

  dimensions = {
    InstanceId = each.key
  }

  tags = {
    environment = "production"
  }
}

resource "aws_cloudwatch_metric_alarm" "disk_alarm" {
  for_each = toset(var.instance_id)

  alarm_name          = "DiskUtilization-${each.key}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent" # CloudWatch agent namespace
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors the disk utilization for instance ${each.key}"
  actions_enabled     = true
  alarm_actions       = [var.reference_sns_topic]
  ok_actions          = [var.reference_sns_topic]

  dimensions = {
    InstanceId = each.key
    path       = "/"
    fstype     = "ext4"
    device     = "nvme0n1p1"
  }

  tags = {
    environment = "production"
  }
}
