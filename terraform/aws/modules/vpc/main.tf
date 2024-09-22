data "aws_vpc" "default" {
  default = true
}

# Delete default sg rule.
# If egress/ingress is not specified, delete sg rule.
resource "aws_default_security_group" "this" {
  vpc_id = data.aws_vpc.default.id
}
