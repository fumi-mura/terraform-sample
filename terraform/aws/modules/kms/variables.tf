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
    sid           = string
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
}
