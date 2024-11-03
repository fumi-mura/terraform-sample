variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "role" {
  type = string
}

variable "policy_statement" {
  type = map(object({
    effect        = string
    actions       = optional(list(string), [])
    not_actions   = optional(list(string), [])
    resource      = optional(list(string), [])
    not_resources = optional(list(string), [])
    condition = list(object({
      test     = string
      variable = string
      values   = list(string)
    }))
  }))
  default     = []
  description = "IAM policy statement list."
}
