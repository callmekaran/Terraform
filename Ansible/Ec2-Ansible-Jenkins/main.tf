resource "aws_instance" "ubuntu_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  key_name                    = var.key_name
  subnet_id                   = data.aws_subnet.default_subnet.id
  vpc_security_group_ids      = [aws_security_group.test-server-sg.id]
  associate_public_ip_address = true
  availability_zone           = "ap-south-1c"

  tags = {
    Name = "Ubuntu22Server"
  }

  provisioner "local-exec" {
    command = <<EOT
      sleep 30
      ansible-playbook -i ${self.public_ip}, -u ubuntu --private-key ./ravat main.yml
    EOT
  }
  provisioner "remote-exec" {
    inline = [ "echo 'Hello World'" ]
  connection {
    host = self.public_ip
    type = "ssh"
    user = "ubuntu"
    private_key = file("./ravat")
  }
  }

}

resource "aws_security_group" "test-server-sg" {
  name        = "test-server-sg"
  description = "Allow inbound and outbound traffic"
  vpc_id      = data.aws_vpc.default_vpc.id
  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "JENKINS from VPC"
    from_port   = 8080
    to_port     = 8080
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
  public_key = file("${path.module}/ravat.pub")
}

output "public_key" {
  value = aws_instance.ubuntu_server.public_ip
}
