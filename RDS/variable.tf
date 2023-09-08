variable "username" {
  default = "greenbox"
}

variable "password" {
  default = "admin1998"
}

variable "instance_type" {
  default = "db.m5.large"
}

variable "storage" {
  default = "20"
}

variable "dbname" {
  default = "terraform-test"
}

variable "dbtype" {
  default = "postgres"
}

variable "dbversion" {
  default = "15.4"
}
