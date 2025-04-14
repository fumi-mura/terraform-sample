resource "aws_budgets_budget" "this" {
  name         = var.budgets_name
  budget_type  = "COST"
  limit_amount = var.limit_amount
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  dynamic "notification" {
    for_each = var.notification

    content {
      comparison_operator        = "GREATER_THAN"
      threshold                  = 100
      threshold_type             = "PERCENTAGE"
      notification_type          = notification.value.notification_type
      subscriber_email_addresses = notification.value.email_addresses
    }
  }

  tags = {
    Nmae = var.budgets_name
  }
}
