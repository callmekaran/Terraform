terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {
    default = "dop_v1_24f9d70c6f7a9b4b"

}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

