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

# Variables
variable "reference_sns_topic" {
  description = "SNS topic ARN for alerts"
  type        = string
  default = "arn:aws:sns:us-east-2:108227242887:HighPriorityAlerts-Ohio"
}

variable "instance_ids" {
  type    = list(string)
  default = [
    "i-044f6de280384765b",  # Ubuntu - TJ Backend API

  ]
}

provider "aws"{
   profile = "tj"
   region = "us-east-2"
}

# CloudWatch Composite Alarm
# CloudWatch Composite Alarm
resource "aws_cloudwatch_composite_alarm" "combined_alarm" {
  for_each = toset(var.instance_ids)

  alarm_name = "CompositeAlarm-${trimspace(data.aws_instance.selected_instances[each.key].tags.Name)}"
  alarm_description = "This alarm monitors CPU and Memory usage for ${trimspace(data.aws_instance.selected_instances[each.key].tags.Name)}."

  # Use alarm_name attribute and replace hyphens with underscores
  alarm_rule = "ALARM(${aws_cloudwatch_metric_alarm.cpu_alarm[each.key].alarm_name}) AND ALARM(${aws_cloudwatch_metric_alarm.memory_alarm[each.key].alarm_name})"

  actions_enabled = true
  alarm_actions   = [var.reference_sns_topic]
  ok_actions      = [var.reference_sns_topic]
}

