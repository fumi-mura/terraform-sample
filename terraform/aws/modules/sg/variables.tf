variable "sg_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ingress_rule_map" {
  type = map(object({
    referenced_security_group_id = string
    from_port                    = number
    to_port                      = number
    ip_protocol                  = string
    cidr_ipv4                    = list(string)
    cidr_ipv6                    = list(string)
    prefix_list_id               = list(string)
    description                  = optional(string)
  }))
}

variable "egress_rule_map" {
  type = map(object({
    referenced_security_group_id = string
    from_port                    = number
    to_port                      = number
    ip_protocol                  = string
    cidr_ipv4                    = list(string)
    cidr_ipv6                    = list(string)
    prefix_list_id               = list(string)
    description                  = optional(string)
  }))
}
