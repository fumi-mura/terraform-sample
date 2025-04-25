variable "users" {
  description = "Create IAM Identity Center users"
  type        = map(object({
    name = object({
      given_name  = string
      family_name = string
    })
    groups = list(string)
  }))
}

variable "email" {
  type = string
}

variable "env" {
  type = string
}

variable "identity_store_id" {
  type = string
}
