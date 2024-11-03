data "aws_iam_policy_document" "this" {
  dynamic "statement" {
    for_each = var.policy_statement
    content {
      effect        = statement.value.effect
      actions       = statement.value.actions
      not_actions   = statement.value.not_actions
      resources     = statement.value.resources
      not_resources = statement.value.not_resources

      dynamic "condition" {
        for_each = statement.value.condition # Execute loop only when use condition.
        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}

resource "aws_iam_policy" "this" {
  name   = "${var.env}-${var.name}-${var.role}-iam-policy"
  policy = data.aws_iam_policy_document.this.json

  tags = {
    Name = "${var.env}-${var.name}-${var.role}-iam-policy"
  }
}
