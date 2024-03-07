provider "aws" {
  region     = "ap-south-1"
}

resource "aws_iam_role" "my_role" {
  name = "my_role"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = { Service = "ec2.amazonaws.com" },
        Action    = "sts:AssumeRole",
      },
    ],
  })
}

resource "aws_iam_policy_attachment" "attach_ssm_policy" {
  name       = "attach_ssm_policy"
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  roles      = [aws_iam_role.my_role.name]
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ssm-installation-role" 
  role = aws_iam_role.my_role.name 
}
        
resource "aws_instance" "example_instance" {
  ami           = "ami-03bb6d83c60fc5f7c"
  instance_type = "t2.micro"
  key_name      = "karan"
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt install amazon-ssm-agent amazon* -y
              sudo systemctl start amazon-ssm-agent
              EOF
)

  tags = {
    Name = "example_instance"
  }
}
