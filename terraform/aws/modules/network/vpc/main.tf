data "aws_vpc" "default" {
  default = true
}

# Delete default sg rule.
# If egress/ingress is not specified, delete sg rule.
resource "aws_default_security_group" "this" {
  vpc_id = data.aws_vpc.default.id
}

# VPC
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}
