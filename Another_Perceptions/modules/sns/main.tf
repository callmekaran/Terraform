provider "aws" {
  profile = "personal"
}

resource "aws_sns_topic" "server_alerts" {
  name = "ServerAlerts"
}

resource "aws_sns_topic_subscription" "email_subscriptions" {
  for_each = toset(var.email_addresses)
  topic_arn = aws_sns_topic.server_alerts.arn
  protocol  = "email"
  endpoint  = each.key
}
