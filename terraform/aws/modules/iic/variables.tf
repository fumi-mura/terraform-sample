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
  type = map(object({
    name = object({
      family_name = string
      given_name  = string
    })
    groups = list(string)
  }))
  description = "Create iic users"
}

variable "groups" {
  type = map(object({
    name = string
    description = string
  }))
  description = "Create iic group"
}

variable "permission_sets" {
  description = "Create iic permission set"
}

variable "user_group_membership" {}
variable "assignment_map" {}
