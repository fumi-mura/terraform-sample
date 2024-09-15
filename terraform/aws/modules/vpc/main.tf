# Bring Default VPC under Terraform management on first run.
resource "aws_default_vpc" "this" {
  force_destroy = true # Allow delete related resource.
}

# Delete default sg rule.
# If egress/ingress is not specified, delete sg rule.
resource "aws_default_security_group" "this" {
  vpc_id = aws_default_vpc.this.id
}
