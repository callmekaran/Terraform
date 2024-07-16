output "website_endpoint" {
  value = module.s3.website_endpoint
}
output "validation_cname_records" {
  value = module.acm.validation_cname_records
}
output "cloudfront_distribution_arn" {
  value = module.cloudfront.cloudfront_distribution_arn
}
output "cloudfront_distribution_domain_name" {
    value = module.cloudfront.cloudfront_distribution_domain_name
  
}