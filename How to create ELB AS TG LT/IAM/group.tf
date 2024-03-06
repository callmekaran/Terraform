resource "aws_iam_user" "karan" {
  name = "karan"
}

resource "aws_iam_group" "aws_team" {
  name = "aws_team"
}

resource "aws_iam_group_policy_attachment" "test-attach" {
  group      = aws_iam_group.aws_team.id
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


resource "aws_iam_user_login_profile" "karan_login_profile" {
  user                    = aws_iam_user.karan.id
  password_reset_required = true  # Set this to true to force a password reset on first login
}

output "karan_password" {
  value = aws_iam_user_login_profile.karan_login_profile.password
}

resource "aws_iam_group_membership" "karan_membership" {
  name = aws_iam_group.aws_team.id
  users = [aws_iam_user.karan.id]
  group = aws_iam_group.aws_team.id  #
}
