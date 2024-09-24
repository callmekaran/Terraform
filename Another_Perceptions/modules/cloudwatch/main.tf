data "aws_instance" "selected_instances" {
  for_each = toset(var.instance_ids)
  instance_id = each.key
}

# CloudWatch CPU Utilization Alarm
resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  for_each = toset(var.instance_ids)

  # Use the instance 'Name' tag in the alarm name
  alarm_name          = "CPUUtilization-Above-70%-${data.aws_instance.selected_instances[each.key].tags.Name}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "CPU utilization for instance ${each.key} exceeded 70%."
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

# CloudWatch Memory Utilization Alarm
resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
  for_each = toset(var.instance_ids)

  # Use the instance 'Name' tag in the alarm name
  alarm_name          = "MemoryUtilization-Above-70%-${data.aws_instance.selected_instances[each.key].tags.Name}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = 60
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Memory utilization for instance ${each.key} exceeded 70%."
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


