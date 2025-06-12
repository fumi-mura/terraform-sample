resource "aws_security_group" "this" {
  name   = var.sg_name
  vpc_id = var.vpc_id

  tags = {
    Name = var.sg_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = var.ingress_rule_map

  security_group_id            = aws_security_group.this.id
  referenced_security_group_id = each.value.referenced_security_group_id
  from_port                    = each.value.from_port
  to_port                      = each.value.to_port
  ip_protocol                  = each.value.ip_protocol
  cidr_ipv4                    = each.value.cidr_ipv4
  cidr_ipv6                    = each.value.cidr_ipv6
  prefix_list_id               = each.value.prefix_list_id
  description                  = each.value.description

  tags = {
    Name = "${var.sg_name}-${each.key}-ingress-rule"
  }
}

resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = var.egress_rule_map

  security_group_id            = aws_security_group.this.id
  referenced_security_group_id = each.value.referenced_security_group_id
  from_port                    = each.value.from_port
  to_port                      = each.value.to_port
  ip_protocol                  = each.value.ip_protocol
  cidr_ipv4                    = each.value.cidr_ipv4
  cidr_ipv6                    = each.value.cidr_ipv6
  prefix_list_id               = each.value.prefix_list_id
  description                  = each.value.description

  tags = {
    Name = "${var.sg_name}-${each.key}-egress-rule"
  }
}
