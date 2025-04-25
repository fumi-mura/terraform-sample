variable "env" {
  type = string
}

variable "name" {
  type = string
}

# variable "permission_sets" {
#   description = "Create IAM Identity Center permission set"
#   type        = list(string)
#   default     = ["AdministratorAccess", "ReadOnlyAccess"]
# }

variable "permission_set_arn" {

}

# variable "users" {
#   description = "Create IAM Identity Center users"
#   type        = list(string)
#   default     = ["Admin", "ReadOnly"]
# }

variable "create_groups" {
  description = "Create IAM Identity Center group"
  type        = list(string)
  default     = ["Admin", "ReadOnly"]
}

# variable "email" {
#   type = string
# }

variable "member_id" {
  type = map(string)
}

variable "account_ids" {
  type = list(string)
}

variable "principal_id" {
  type = string
}

# variable "account_assignments" {
#   description = "アカウント、権限セット、プリンシパルの関連付け"
#   type = map(object({
#     target_id          = string
#     permission_set_arn = string
#     principal_id       = string
#   }))
# }
