output "cloudfront_distribution_arn" {
  value = aws_cloudfront_distribution.my_distribution.arn
}
output "cloudfront_distribution_domain_name" {
    value = aws_cloudfront_distribution.my_distribution.domain_name
  
}