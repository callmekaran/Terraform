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

resource "aws_iam_user_login_profile" "karan_login_profile" {
  user                    = aws_iam_user.karan.name
  password_reset_required = true  
}

output "karan_user_password" {
  value = aws_iam_user_login_profile.karan_login_profile.password
}

