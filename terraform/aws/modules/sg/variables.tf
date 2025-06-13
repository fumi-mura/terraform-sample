variable "sg_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ingress_rule_map" {
  type = map(object({
    from_port                    = number
    to_port                      = number
    ip_protocol                  = string
    cidr_ipv4                    = string
    cidr_ipv6                    = optional(string)
    referenced_security_group_id = optional(string)
    prefix_list_id               = optional(string)
    description                  = optional(string)
  }))
  description = "Exactly one of these attributes must be configured: [cidr_ipv4,cidr_ipv6,prefix_list_id,referenced_security_group_id]"
}

variable "egress_rule_map" {
  type = map(object({
    from_port                    = number
    to_port                      = number
    ip_protocol                  = string
    cidr_ipv4                    = string
    cidr_ipv6                    = optional(string)
    referenced_security_group_id = optional(string)
    prefix_list_id               = optional(string)
    description                  = optional(string)
  }))
  description = "Exactly one of these attributes must be configured: [cidr_ipv4,cidr_ipv6,prefix_list_id,referenced_security_group_id]"
}
