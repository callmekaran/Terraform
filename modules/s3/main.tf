resource "aws_s3_bucket" "mybucket" {
    bucket = var.bucketname
}

resource "aws_s3_bucket_website_configuration" "mywebsite" {
  bucket = aws_s3_bucket.mybucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "index.html"
  source = "/home/rlogical-lap-23/Terraform/modules/s3/index.html"
  content_type = "text/html"
}


resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.mybucket.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "PolicyForCloudFrontPrivateContent",
  "Statement": [
    {
      "Sid": "AllowCloudFrontServicePrincipal",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudfront.amazonaws.com"
      },
      "Action": "s3:GetObject",
      "Resource": "${aws_s3_bucket.mybucket.arn}/*",
      "Condition": {
        "StringEquals": {
          "AWS:SourceArn": "${var.cloudfront_arn}"
        }
      }
    }
  ]
}
EOF
}
