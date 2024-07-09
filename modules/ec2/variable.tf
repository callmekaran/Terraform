variable "public_subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "key_name" {
  default = "ravat" # Default value, can be overridden
}