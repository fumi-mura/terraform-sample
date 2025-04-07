variable "account_names" {
  description = "Names for the AWS accounts to be created"
  type        = list(string)
}

variable "email" {
  type = string
}

variable "ou_name" {
  type = string
}
