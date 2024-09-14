variable "env" {}
variable "account_names" {
  description = "Names for the AWS accounts to be created"
  type        = list(string)
  default     = [ "prd", "dev" ]
}
