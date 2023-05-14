provider "aws" {
  region     = "ap-south-1"
  access_key = "NA"
  secret_key = "NA/Z2jD04sYm"
}
resource "aws_ami_from_instance" "test" {
  name               = "test-ami"
  source_instance_id = "i-xxx"
  snapshot_without_reboot = "true"
  tags = {
     Name = "test-ami"
}
}
