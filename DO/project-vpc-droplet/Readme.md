# DigitalOcean Terraform Configuration

This Terraform configuration is designed to automate the setup of essential infrastructure on DigitalOcean. The code will create the following resources:

1. **Project**: A DigitalOcean project to organize your resources.
2. **Droplet**: A virtual server (Droplet) that runs your applications.
3. **VPC (Virtual Private Cloud)**: A private network for your resources, providing better security and control.
4. **Firewall**: A firewall to manage and restrict traffic, which will be attached to the Droplet.
5. **Monitoring**: It will create Alerts, regarding cpu, memory, disk

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
- A DigitalOcean account with an API token. You can generate a token by following the [DigitalOcean API Token guide](https://docs.digitalocean.com/reference/api-create-personal-access-token/).
