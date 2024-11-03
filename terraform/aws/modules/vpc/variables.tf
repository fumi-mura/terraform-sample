variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "role" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
  type = map(object({
    cidr = string
    az   = string
    role = string
  }))
}

variable "private_subnets" {
  type = map(object({
    cidr = string
    az   = string
    role = string
  }))
}

variable "db_subnets" {
  type = map(object({
    cidr = string
    az   = string
    role = string
  }))
}
