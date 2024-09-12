variable "refrence-vpc1-id" {}
variable "refrence-vpc1-rt-id" {}
variable "refrence-vpc1-public-subnet-cidr-block" {}

variable "vpc1-cidr-block" {
  description = "CIDR block for VPC1"
  type        = string
  default     = "192.168.0.0/16"
}

variable "vpc1-public-subnet-cidr-block" {
  description = "CIDR block for the public subnet in VPC1"
  type        = string
  default     = "192.168.1.0/24"
}

variable "vpc1-private-subnet-cidr-block" {
  description = "CIDR block for the private subnet in VPC1"
  type        = string
  default     = "192.168.2.0/24"
}
