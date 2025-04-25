variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "permission_set_arn" {

}

variable "create_groups" {
  description = "Create IAM Identity Center group"
  type        = list(string)
  default     = ["Admin", "ReadOnly"]
}

variable "member_id" {
  type = map(string)
}

variable "account_ids" {
  type = list(string)
}

variable "principal_id" {
  type = string
}
