variable "ip_range" {
  default = "192.168.0.0/24"
}

variable "vpc-name" {
  default = "devops-vpc"
}

variable "project-name" {
  default = "Rlogical-Devops"
}

variable "environment" {
  default = "development" # or "staging" or "production"
}

variable "region" {
  default = "nyc3"
}

variable "droplet_tag" {
  default = "Devops-Test"
}

variable "ami" {
  default = "ubuntu-22-04-x64"
}

variable "instance_type" {
  default = "s-1vcpu-1gb"
}


