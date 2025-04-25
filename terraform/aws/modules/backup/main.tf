data "aws_kms_key" "this" {
  key_id = "alias/aws/backup"
}

resource "aws_backup_vault" "this" {
  name        = var.vault_name
  kms_key_arn = data.aws_kms_key.this.arn

  tags = {
    Name = var.vault_name
  }
}

resource "aws_backup_selection" "this" {
  name         = var.selection_name
  iam_role_arn = var.iam_role_arn
  plan_id      = aws_backup_plan.this.id
  resources    = var.resources

  dynamic "condition" {
    for_each = var.conditions

    content {
      string_equals {
        key   = condition.value.key
        value = condition.value.value
      }
    }
  }
}

resource "aws_backup_plan" "this" {
  name = var.plan_name

  rule {
    rule_name         = var.rule_name
    target_vault_name = aws_backup_vault.this.name
    schedule          = "cron(0 3 * * ? *)" # AM 03:00 Asia/Tokyo
    completion_window = "120"

    lifecycle {
      delete_after = 5
    }
  }

  advanced_backup_setting {
    backup_options = {
      WindowsVSS = "disabled"
    }
    resource_type = "EC2"
  }

  tags = {
    Name = var.plan_name
  }
}
