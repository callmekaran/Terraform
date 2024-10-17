provider "aws" {
  region  = "ap-south-1"
  profile = "personal"
}


# Security group with dynamic ingress rules and allow all egress rule
resource "aws_security_group" "temp_sg" {
  name   = "temp-sg"
  vpc_id = data.aws_vpc.default_vpc.id

  # Dynamic ingress block for each port in the list
  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow ingress on port ${ingress.value}"
    }
  }

  # Allow all outbound (egress) traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 indicates all protocols
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}

output "security_group_id" {
  value = aws_security_group.temp_sg.id
}
