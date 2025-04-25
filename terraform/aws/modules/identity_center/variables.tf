variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "permission_set_arn" {

}

variable "groups" {
  description = "Create IAM Identity Center group"
  type        = map(object({
    name = string
  }))
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
