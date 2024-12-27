variable "iam_role_name" {
  type = string
}

variable "policy_statement" {
  type = map(object({
    effect        = string
    actions       = optional(list(string), [])
    not_actions   = optional(list(string), [])
    resources     = optional(list(string), [])
    not_resources = optional(list(string), [])
    principals = list(object({
      type        = string
      identifiers = list(string)
    }))
    condition = list(object({
      test     = string
      variable = string
      values   = list(string)
    }))
  }))
  description = "IAM policy statement list."
}

variable "managed_policy_arns" {
  type = list(string)
}

variable "max_session_duration" {
  type    = number
  default = 3600
}
