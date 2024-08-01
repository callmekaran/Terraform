variable "email_addresses" {
  description = "List of email addresses to subscribe to the SNS topic"
  type        = list(string)
}
variable "key_name" {
  default = "ravat" # Default value, can be overridden
}
variable "reference_sns_topic" {
  description = "SNS topic ARN for alerts"
  type        = string
}
variable "instance_id" {
  description = "EC2 InstanceID"
  type        = string  
}
