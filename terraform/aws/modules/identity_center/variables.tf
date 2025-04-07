variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "permission_sets" {
  description = "Create IAM Identity Center permission set"
  type        = list(string)
  default     = ["AdministratorAccess", "ReadOnlyAccess"]
}

variable "create_users" {
  description = "Create IAM Identity Center users"
  type        = list(string)
  default     = ["Admin", "ReadOnly"]
}

variable "create_groups" {
  description = "Create IAM Identity Center group"
  type        = list(string)
  default     = ["Admin", "ReadOnly"]
}

variable "email_local_pert" {
  type = string
}

variable "account_ids" {
  type = list(string)
}
