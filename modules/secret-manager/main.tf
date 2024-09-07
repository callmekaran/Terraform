resource "aws_secretsmanager_secret" "karan_secret1" {
  name = "karan_secret1"
  description = "For Testing Purpose"
}

resource "aws_secretsmanager_secret_version" "name" {
  secret_id     = aws_secretsmanager_secret.karan_secret1.id
  secret_string = jsonencode(var.secret_values)
  depends_on = [ aws_secretsmanager_secret.karan_secret1 ]
}
