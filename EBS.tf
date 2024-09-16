#Create EBS Dynamically 

resource "aws_ebs_volume" "example" {
  availability_zone = element(var.availability_zones, count.index) # To Create one ebs in one az
  size              = 8
  count = length(var.availability_zones) #it will take value dynamiclayy from az var

  tags = {
    Name = "HelloWorld${count.index}"
  }
}

provider "aws" {
  profile = "personal"
}


variable "availability_zones" {
  description = "List of availability zones to distribute the volumes"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
