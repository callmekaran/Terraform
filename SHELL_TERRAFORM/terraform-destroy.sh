#!/bin/bash

# Define directories for each Terraform module
VPC_DIR="/home/rlogical-lap-23/terraform/vpc"
EC2_DIR="/home/rlogical-lap-23/terraform/ec2"
RDS_DIR="/home/rlogical-lap-23/terraform/rds"

# Destroy EC2 resources
echo "Executing module: EC2"
cd "$EC2_DIR"
terraform destroy --auto-approve

# Destroy RDS resources
echo "Executing module: RDS"
cd "$RDS_DIR"
terraform destroy --auto-approve

# Destroy VPC resources
echo "Executing module: VPC"
cd "$VPC_DIR"
terraform destroy --auto-approve
