variable "bucketname" {
    description = "This variable defines Bucket"
    type = string
}
variable "domain_name" {
    description = "Domain Name"
    type = string
}
variable "cloudfront_arn" {
  description = "ARN of the CloudFront distribution"
  type        = string
}
