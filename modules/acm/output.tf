output "validation_cname_records" {
  value = [
    for dvo in aws_acm_certificate.cert.domain_validation_options : {
      name  = dvo.resource_record_name
      value = dvo.resource_record_value
    }
  ]
}

output "certificate_arn" {
  value = aws_acm_certificate.cert.arn
}