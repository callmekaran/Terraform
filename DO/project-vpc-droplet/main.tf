resource "digitalocean_vpc" "example" {
  name     = "example-project-network"
  region   = "nyc3"
  ip_range = "10.10.10.0/24"
}


resource "digitalocean_project" "rlogical-devops" {
  name        = "Rlogical-Devops"
  description = "A project to represent development resources."
  purpose     = "Web Application"
  environment = "Development"
}

resource "digitalocean_droplet" "foobar" {
  name   = "example"
  size   = "s-1vcpu-1gb"
  image  = "ubuntu-22-04-x64"
  region = "nyc3"
  monitoring = true
  backups = true
  vpc_uuid = digitalocean_vpc.example.id
  ssh_keys = [digitalocean_ssh_key.default.id]  
  tags = [ "Devops-Test" ]
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
