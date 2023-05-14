provider "aws" {
  region     = "ap-south-1"
  access_key = "AK4OG5WU"
  secret_key = "L/Z2jD04sYm"
}
resource "aws_s3_bucket" "example" {
  bucket = "my-tf12-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

#By Default Public Access is Private 

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = "${aws_s3_bucket.example.id}"

  block_public_acls   = true
  block_public_policy = true
}
