data "aws_iam_policy_document" "kms" {
  dynamic "statement" {
    for_each = var.policy_statement
    content {
      sid           = statement.value.sid
      effect        = statement.value.effect
      actions       = statement.value.actions
      not_actions   = statement.value.not_actions
      resources     = statement.value.resources
      not_resources = statement.value.not_resources

      dynamic "principals" {
        for_each = statement.value.principals
        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

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

resource "aws_kms_key" "this" {
  enable_key_rotation     = true # Default rotation is 365 days. Cannot be changed from tf.
  deletion_window_in_days = 7    # Requires 7-30 days waiting period before deletion.

  tags = {
    Name = "${var.env}-${var.name}-${var.role}-kms"
  }
}

resource "aws_kms_alias" "this" {
  name          = "alias/${var.env}-${var.name}-${var.role}-kms"
  target_key_id = aws_kms_key.this.key_id
}

resource "aws_kms_key_policy" "this" {
  key_id = aws_kms_key.this.id
  policy = data.aws_iam_policy_document.kms.json
}
