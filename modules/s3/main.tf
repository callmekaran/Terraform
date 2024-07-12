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

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "index.html"
  source = "/home/rlogical-lap-23/Terraform/modules/s3/index.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.mybucket.id
   policy = <<POLICY
{
  "Id": "Policy",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.mybucket.id}/*",
      "Principal": "*"
    }
  ]
}
POLICY
}
