variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "role" {
  type = string
}

variable "prefix" {
  type = string
}

variable "retention_in_days" {
  type    = number
  default = 30
}
