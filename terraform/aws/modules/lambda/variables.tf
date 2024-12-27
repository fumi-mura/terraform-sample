variable "funcion_name" {
  type = string
}

variable "role_arn" {
  type = string
}

variable "source_dir" {
  type    = string
  default = "default"
}

variable "handler" {
  type    = string
  default = "lambda_function.lambda_handler"
}

variable "runtime" {
  type = string
}

variable "memory_size" {
  type = number
}

variable "timeout" {
  type = number
}

variable "layers" {
  type = list(string)
}

variable "environment_variables" {
  type = map(string)
}
