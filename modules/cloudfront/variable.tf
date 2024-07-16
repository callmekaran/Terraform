variable "domain_name" {
    description = "Domain Name"
    type = string
}
variable "acm_certificate_arn" {
  description = "ACM Certificate ARN"
  type        = string
}
variable "bucket_domain_name" {
  description = "The domain name of the S3 bucket"
  type        = string
}
variable "cloudfront_arn" {
  type = string
}
