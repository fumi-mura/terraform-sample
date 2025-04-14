variable "budgets_name" {
  type = string
}

variable "notification" {
  type = map(object({
    notification_type = string
    email_addresses   = list(string)
  }))
}
