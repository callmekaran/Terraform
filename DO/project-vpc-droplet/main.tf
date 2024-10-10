resource "digitalocean_vpc" "example" {
  name     = var.vpc-name
  region   = var.region
  ip_range = var.ip_range
}

resource "digitalocean_project" "rlogical-devops" {
  name        = var.project-name
  description = "A project to represent development resources."
  purpose     = "Web Application"
  environment = var.environment
}

resource "digitalocean_droplet" "foobar" {
  name   = var.droplet_tag
  size   = var.instance_type
  image  = var.ami
  region = var.region
  monitoring = true
  backups = true
  vpc_uuid = digitalocean_vpc.example.id
  ssh_keys = [digitalocean_ssh_key.default.id]  
  tags = [var.droplet_tag]
}


resource "digitalocean_project_resources" "barfoo" {
  project = digitalocean_project.rlogical-devops.id
  resources = [
    digitalocean_droplet.foobar.urn,
    digitalocean_vpc.example.urn,
    digitalocean_ssh_key.default.id # Using .urn for the resource URN
  ]
}

resource "digitalocean_ssh_key" "default" {
  name       = "Terraform Example"
  public_key = file("/home/rlogical-lap-23/DO/test.pub")
}

locals {
  alert_types = {
    "v1/insights/droplet/cpu"                    = "CPU"
    "v1/insights/droplet/disk_utilization_percent" = "Disk"
    "v1/insights/droplet/memory_utilization_percent" = "Memory"
  }
}

resource "digitalocean_monitor_alert" "alerts" {
  for_each = local.alert_types

  alerts {
    email = ["karan.ravat@digitalocean.com"]
  }
  
  window      = "5m"
  type        = each.key
  compare     = "GreaterThan"
  value       = 75
  enabled     = true
  entities    = [digitalocean_droplet.foobar.id]
  description = "Alert for ${each.value} usage above 75% for Droplet Tag: ${var.droplet_tag}"
}


resource "digitalocean_firewall" "web-firewall" {
  name = "only-22-80-and-443"

  droplet_ids = [digitalocean_droplet.foobar.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["192.168.1.0/24"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
