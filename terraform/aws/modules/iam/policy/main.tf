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
        for_each = statement.value.condition
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
  name   = var.iam_policy_name
  policy = data.aws_iam_policy_document.this.json

  tags = {
    Name = var.iam_policy_name
  }
}
