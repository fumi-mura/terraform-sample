variable "permission_sets" {
  description = "Create IAM Identity Center permission set"
  type        = list(string)
  default     = ["AdministratorAccess", "ReadOnlyAccess"]
}

variable "ssoadmin_instances_arn" {
  # type = string
}
