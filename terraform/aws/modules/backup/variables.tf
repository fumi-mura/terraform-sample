variable "plan_name" {
  type = string
}

variable "rule_name" {
  type = string
}

variable "vault_name" {
  type = string
}

variable "selection_name" {
  type = string
}

variable "iam_role_arn" {
  type = string
}

variable "resources" {
  type = list(string)
}

variable "conditions" {
  type = map(object({
    key   = string
    value = string
  }))
}
