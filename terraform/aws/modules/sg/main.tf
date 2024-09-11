# # Delete default sg rule
# # If egress/ingress is not specified, delete sg rule.
resource "aws_default_security_group" "this" {
  vpc_id = var.default_vpc_id
}
