data "aws_iam_policy_document" "assume_role" {
  dynamic "statement" {
    for_each = var.policy_statement
    content {
      effect        = statement.value.effect
      actions       = statement.value.actions
      not_actions   = statement.value.not_actions
      not_resources = statement.value.not_resources
      dynamic "principals" {
        for_each = statement.value.principals
        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }
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

resource "aws_iam_role" "this" {
  name                 = "${var.env}-${var.name}-${var.role}-iam-role"
  assume_role_policy   = data.aws_iam_policy_document.assume_role.json
  managed_policy_arns  = var.managed_policy_arns
  max_session_duration = var.max_session_duration

  tags = {
    Name = "${var.env}-${var.name}-${var.role}-iam-role"
  }
}
