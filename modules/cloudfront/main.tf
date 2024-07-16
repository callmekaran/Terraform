resource "aws_cloudfront_distribution" "my_distribution" {
  origin {
    domain_name           = var.bucket_domain_name
    origin_id             = "files_oac"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  origin {
    domain_name           = var.bucket_domain_name
    origin_id             = "files_oai"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oac.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    target_origin_id       = "files_oac"  # Ensure this matches your S3 origin_id
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = data.aws_cloudfront_cache_policy.example.id
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
  }

  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }

  aliases              = [var.domain_name]
  default_root_object  = "index.html"  # Set default root object

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  enabled = true
}

data "aws_cloudfront_cache_policy" "example" {
  name = "Managed-CachingOptimized"
}


resource "aws_cloudfront_origin_access_control" "oac" {
  name = var.bucket_domain_name
 	signing_behavior                  = "always"
	signing_protocol                  = "sigv4"
 	origin_access_control_origin_type = "s3"
}

resource "aws_cloudfront_origin_access_identity" "oac" {
  comment = "Access control for CloudFront to S3"
}
