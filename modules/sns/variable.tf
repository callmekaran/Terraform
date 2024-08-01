variable "email_addresses" {
  description = "List of email addresses to subscribe to the SNS topic"
  type        = list(string)
}
variable "reference_sns_topic" {
  description = "SNS topic ARN for alerts"
  type        = string
}
