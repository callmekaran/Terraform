resource "aws_ssm_parameter" "alert_config" {
  name        = "/alarm/AWS-CWAgentLinConfig"
  description = "Memory & Disk Utilization Configuration"
  type        = "String"
  data_type   = "text"
  value       = local.config_json

  tags = {
    environment = "production"
  }
}

