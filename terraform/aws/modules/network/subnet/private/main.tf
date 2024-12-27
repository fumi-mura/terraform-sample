resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = "ap-northeast-${each.value.az}"

  tags = {
    Name = "${var.env}-${var.name}-private-subnet-${each.value.az}"
  }
}

resource "aws_route_table" "private" {
  for_each = var.private_subnets

  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = var.private_route_map
    content {
      cidr_block         = route.value.cidr_block
      nat_gateway_id     = route.value.nat_gateway_id
      vpc_endpoint_id    = route.value.vpc_endpoint_id
      transit_gateway_id = route.value.transit_gateway_id
    }
  }

  tags = {
    Name = "${var.env}-${var.name}-private-rt-${each.value.az}"
  }
}

resource "aws_route_table_association" "private" {
  for_each = var.private_subnets

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}
