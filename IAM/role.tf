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

