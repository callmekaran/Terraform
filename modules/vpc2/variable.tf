variable "refrence-vpc2-id" {}
variable "refrence-vpc2-rt-id" {}
variable "refrence-vpc2-public-subnet-cidr-block" {}
variable "vpc2-private-subnet-cidr-block" {
  default = "172.158.2.0/24"
}

variable "vpc2-public-subnet-cidr-block" {
  default = "172.158.1.0/24"
}

variable "vpc2-cidr-block" {
  default = "172.158.0.0/16"
}

