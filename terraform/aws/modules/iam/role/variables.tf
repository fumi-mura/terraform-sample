variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "role" {
  type = string
}

variable "resources" {
  type = list(string)
}

variable "assume_type" {
  type = string
}

variable "assume_identifiers" {
  type = list(string)
}

variable "managed_policy_arns" {
  type = list(string)
}

variable "max_session_duration" {
  type = number
  default = 3600
}
