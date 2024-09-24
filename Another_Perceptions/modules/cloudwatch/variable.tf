variable "reference_sns_topic" {
  description = "SNS topic ARN for alerts"
  type        = string
}
variable "instance_id" {
  type    = list(string)
  default = [
    "i-03f522eb5978ee74f",
    "i-0885f23921c4f1a34"
  ]
}
