variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "email" {
  type = string
}

variable "users" {
  description = "Create IIC users"
}

variable "groups" {
  description = "Create IIC group"
}

variable "permission_sets" {
  description = "Create IIC permission set"
}

variable "user_group_membership" {}
variable "assignment_map" {}
