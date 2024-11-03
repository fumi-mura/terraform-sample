resource "aws_vpc_endpoint" "this" {
  vpc_endpoint_type   = var.vpc_endpoint_type
  service_name        = var.service_name
  vpc_id              = var.vpc_id
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.sg_ids

  tags = {
    Name = "${var.env}-${var.name}-${var.role}-vpc-endpoint"
  }
}
