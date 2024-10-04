# AWS provider configuration
provider "aws" {
  profile = "personal"
  region  = "ap-south-1"
}

#Step 1: Fetch the default VPC
data "aws_vpc" "default" {
  default = true
}

# Step 2: Fetch the Subnets in the default VPC
data "aws_subnets" "default_vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Step 3: Fetch subnet details for each subnet in the VPC
data "aws_subnet" "default_vpc_subnet_details" {
  for_each = toset(data.aws_subnets.default_vpc_subnets.ids)
  id       = each.value
}

# Output the VPC ID
output "vpc_id" {
  value = data.aws_vpc.default.id
}

#Step 4: Create an AWS Secrets Manager secret for the RDS credentials
resource "random_password" "rds_password" {
  length  = 10
  special = true
}

resource "aws_secretsmanager_secret" "rds_secret" {
  name = "rds-credentials-secret"
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id = aws_secretsmanager_secret.rds_secret.id

  secret_string = jsonencode({
    username = "admin"
    password = random_password.rds_password.result
  })
}


#Step 5: Create the RDS instance using the credentials stored in Secrets Manager
resource "aws_db_instance" "example" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_subnet_group_name = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.allow_rds.id]
  username             = jsondecode(aws_secretsmanager_secret_version.rds_secret_version.secret_string)["username"]
  password             = jsondecode(aws_secretsmanager_secret_version.rds_secret_version.secret_string)["password"]
  skip_final_snapshot  = true
  publicly_accessible = true
}

# Step 6: Create a DB Subnet Group for RDS
resource "aws_db_subnet_group" "default" {
  name       = "main-subnet-group"
  subnet_ids = data.aws_subnets.default_vpc_subnets.ids

  tags = {
    Name = "Main subnet group"
  }
}

# Step 7: Create a security group allowing access to RDS

resource "aws_security_group" "allow_rds" {
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Step 8: Output RDS information
output "rds_endpoint" {
  value = aws_db_instance.example.endpoint
}

output "rds_username" {
  value = jsondecode(aws_secretsmanager_secret_version.rds_secret_version.secret_string)["username"]
  sensitive = true
}

output "rds_password" {
  value = jsondecode(aws_secretsmanager_secret_version.rds_secret_version.secret_string)["password"]
  sensitive = true

}
