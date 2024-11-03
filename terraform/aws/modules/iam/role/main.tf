data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = [ "sts:AssumeRole" ]
    resources = var.resources

    principals {
      type        = var.assume_type
      identifiers = var.assume_identifiers
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
