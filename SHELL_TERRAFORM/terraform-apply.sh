#!/bin/bash

# Define the directory paths for each Terraform module
VPC_DIR="/home/rlogical-lap-23/terraform/vpc"
EC2_DIR="/home/rlogical-lap-23/terraform/ec2"
RDS_DIR="/home/rlogical-lap-23/terraform/rds"

# Function to execute Terraform commands for a module
execute_terraform() {
    local module_name="$1"
    local module_dir="$2"

    echo "Executing module: $module_name"
    cd "$module_dir"
    terraform init
    terraform plan -out=tfplan_$module_name
    terraform apply tfplan_$module_name
}

execute_terraform "VPC" "$VPC_DIR"
execute_terraform "EC2" "$EC2_DIR"
execute_terraform "RDS" "$RDS_DIR"
