variable "iam_policy_name" {
  type = string
}

variable "policy_statement" {
  type = map(object({
    effect        = string
    actions       = optional(list(string), [])
    not_actions   = optional(list(string), [])
    resources     = optional(list(string), [])
    not_resources = optional(list(string), [])
    condition = list(object({
      test     = string
      variable = string
      values   = list(string)
    }))
  }))
  description = "IAM policy statement list."
}
