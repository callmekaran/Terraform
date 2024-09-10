variable "secret_values" {
  default = {

    "karan"  = "ravat"
    "bharat" = "ravat"

  }
  type = map(string)
}
variable "reference_secret_manager" {}
