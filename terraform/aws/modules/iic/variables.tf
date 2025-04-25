variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "permission_sets" {
  description = "Create IIC permission set"
}

variable "users" {
  description = "Create IIC users"
}

variable "groups" {
  description = "Create IIC group"
}

variable "email" {
  type = string
}

variable "account_ids" {
  type = map(string)
}

variable "user_group_membership" {}
variable "assignment_map" {}
