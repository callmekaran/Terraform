terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.14.0"
    }
  }
}

resource "aws_lightsail_instance" "test-instance" {

    name = var.instance_name
    availability_zone = var.az
    bundle_id = var.instance_type
    blueprint_id = var.os
    tags = {
      Name =  "Php_HK"
    }

}

resource "aws_lightsail_static_ip" "static-ip" {

   name = var.static_ip_name

}

resource "aws_lightsail_static_ip_attachment" "static-ip-attchment" {

   instance_name = aws_lightsail_instance.test-instance.id
   static_ip_name = aws_lightsail_static_ip.static-ip.name
 
}

resource "aws_lightsail_key_pair" "keypair" {

    name = var.keypair
  
}
