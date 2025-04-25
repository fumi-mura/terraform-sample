variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "permission_sets" {
  description = "Create IAM Identity Center permission set"
}

variable "users" {
  description = "Create IAM Identity Center users"
}

variable "groups" {
  description = "Create IAM Identity Center group"
}

variable "email" {
  type = string
}

variable "account_ids" {
  type = map(string)
}

variable "users_groups_membership" {}
variable "assignment_map" {}
