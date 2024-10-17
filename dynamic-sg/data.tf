# Get the default VPC
data "aws_vpc" "default_vpc" {
  filter {
    name   = "isDefault"
    values = ["true"]
  }
}
