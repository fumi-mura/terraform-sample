variable "users" {
  description = "Create IAM Identity Center users"
  type        = list(string)
  default     = ["Admin", "ReadOnly"]
}

variable "email" {
  type = string
}

variable "env" {
  type = string
}

variable "ssoadmin_instances_identity_store_ids" {
  type = string
}
