resource "aws_iam_user" "this" {
  name = "${var.env}-${var.name}-${var.role}-iam-user"
  path = "/"

  tags = {
    Name = "${var.env}-${var.name}-${var.role}-iam-user"
  }
}

resource "aws_iam_user_policy_attachment" "this" {
  for_each   = toset(var.policy_arn)
  user       = aws_iam_user.this.name
  policy_arn = each.value
}
