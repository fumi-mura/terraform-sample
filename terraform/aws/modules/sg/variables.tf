variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "role" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "description" {
  type    = string
  default = "Managed by Terraform" # Default value by terraform.
}

variable "rule_map" {
  type = map(object({
    type                     = string
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = list(string)
    prefix_list_ids          = list(string)
    ipv6_cidr_blocks         = list(string)
    source_security_group_id = string
    description              = optional(string)
  }))
}
