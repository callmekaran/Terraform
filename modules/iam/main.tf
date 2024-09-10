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

resource "aws_iam_role" "ssm_role" {
  name = "ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ssm.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "ssm_role_policy_attachment" {
  name       = "ssm-role-policy-attachment"
  roles      = [aws_iam_role.ssm_role.name]
  policy_arn  = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_policy_attachment" "ssm_role_policy_attachment_session" {
  name       = "ssm-role-policy-attachment-session"
  roles      = [aws_iam_role.ssm_role.name]
  policy_arn  = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_policy_attachment" "secret-manager-fetch-secret-attachment-policy" {
  name       = "secret-manager-fetch-secret-attachment-policy"
  roles      = [aws_iam_role.ssm_role.name]
  policy_arn  = aws_iam_policy.example.arn
}

