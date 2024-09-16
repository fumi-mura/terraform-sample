variable "env" {
  type = string
}
variable "name" {
  type = string
}
variable "sns_name" {
  type = string
}
variable "sns_policy" {
  type = map(string)
}
variable "sns_protocol" {
  type = string
}
variable "sns_endpoint" {
  type = string
}
variable "function_name" {
  type = string
}
