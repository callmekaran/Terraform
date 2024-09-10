resource "aws_iam_policy" "example" {
  name = "example-policy"
  description = "An example policy that references Secrets Manager ARN"


  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "secretsmanager:GetSecretValue",
        Effect   = "Allow",
        Resource = var.reference_secret_manager
      }
    ]
  })
}
