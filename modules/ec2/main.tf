resource "aws_instance" "ubuntu_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  key_name                    = var.key_name
  associate_public_ip_address = true
  iam_instance_profile = data.aws_iam_instance_profile.ssm_instance_profile.name

  tags = {
    Name = "Ubuntu22Server"
  }
  user_data = file("/home/rlogical-lap-23/Terraform/modules/ec2/cloudwatch.sh")


}

resource "aws_security_group" "test-server-sg" {
  name        = "test-server-sg"
  description = "Allow inbound and outbound traffic"
  vpc_id      = data.aws_vpc.default.id
  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All Port ALLOW"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

#ssh-keygen -t rsa -b 2048 -f ravat

resource "aws_key_pair" "ravat" {
  key_name   = var.key_name
  public_key = file("${path.module}/my-kwy.pub")
}

resource "aws_eip" "test_eip" {
  instance = aws_instance.ubuntu_server.id
  domain   = "vpc"

  tags = {
    Name = "Test"
  }

}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.ubuntu_server.id
  allocation_id = aws_eip.test_eip.id
}
