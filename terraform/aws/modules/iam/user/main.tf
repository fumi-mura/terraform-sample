resource "aws_iam_user" "this" {
  name = var.iam_user_name
  path = "/"

  tags = {
    Name = var.iam_user_name
  }
}

resource "aws_iam_user_policy_attachment" "this" {
  for_each   = toset(var.policy_arn)
  user       = aws_iam_user.this.name
  policy_arn = each.value
}
