provider "aws" {
  profile = "personal"
}

resource "aws_secretsmanager_secret" "karan_secret" {
  name = "karan_secret"
  description = "For Testing Purpose"
}

resource "aws_secretsmanager_secret_version" "name" {
  secret_id     = aws_secretsmanager_secret.karan_secret.id
  secret_string = jsonencode(var.secret_values)
  depends_on = [ aws_secretsmanager_secret.karan_secret ]
}

