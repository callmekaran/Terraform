#basic create iam user and give permission


provider "aws" {
  region = "us-east-1"  # Change to your desired AWS region
}

resource "aws_iam_user" "karan" {
  name = "karan"
}

resource "aws_iam_user_policy_attachment" "admin_access" {
  user       = aws_iam_user.karan.id
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
