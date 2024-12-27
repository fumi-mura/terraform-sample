resource "aws_vpc_endpoint" "this" {
  vpc_endpoint_type  = var.vpce_type
  service_name       = var.service_name
  vpc_id             = var.vpc_id
  subnet_ids         = var.subnet_ids
  security_group_ids = var.sg_ids

  tags = {
    Name = var.vpce_name
  }
}
