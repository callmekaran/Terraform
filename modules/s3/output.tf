output "website_endpoint" {
    value = aws_s3_bucket_website_configuration.mywebsite.website_endpoint
}
output "bucket_domain_name" {
  value = aws_s3_bucket.mybucket.bucket_regional_domain_name
}
output "bucket_endpoint" {
  value = aws_s3_bucket.mybucket.arn
}
