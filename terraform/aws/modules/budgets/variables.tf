variable "budgets_name" {
  type = string
}

variable "limit_amount" {
  type = number
}

variable "notification" {
  type = map(object({
    notification_type = string
    email_addresses   = list(string)
  }))
}
