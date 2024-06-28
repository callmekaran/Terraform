resource "aws_instance" "ubuntu_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  key_name               = "karan"
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.test-server-sg.id]
  associate_public_ip_address = true
  availability_zone          = "ap-south-1c"
  tags = {
    Name = "Ubuntu22Server"
  }

  root_block_device {
    delete_on_termination = true
    volume_size           = 50
    volume_type           = "gp2"
  }
}

resource "aws_ebs_volume" "example" {
  size              = 40
  availability_zone = "ap-south-1c"
  type              = "gp3"

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.ubuntu_server.id
  device_name = "/dev/sdd"
}

resource "aws_security_group" "test-server-sg" {
  name        = "test-server-sg"
  description = "Allow inbound and outbound traffic"
  vpc_id = var.vpc_id
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
  key_name   = ravat
  public_key = file("${path.module}/ravat.pub")
}

