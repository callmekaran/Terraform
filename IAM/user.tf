resource "aws_iam_user" "example" {
  name          = "example"
}

resource "aws_iam_policy" "my_developer_policy" {
  name  = "administrator"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = aws_iam_user.example.id
  policy_arn = aws_iam_policy.my_developer_policy.id
}

resource "aws_iam_user_login_profile" "example" {
  user = aws_iam_user.example.name
  password_length = 10
  password_reset_required = true
}

output "password" {
  value = aws_iam_user_login_profile.example.password
}
