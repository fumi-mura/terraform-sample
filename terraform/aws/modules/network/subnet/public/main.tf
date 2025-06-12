resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr
  availability_zone       = "ap-northeast-${each.value.az}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env}-${var.name}-public-subnet-${each.value.az}"
  }
}

resource "aws_route_table" "public" {
  for_each = var.public_subnets

  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = var.public_route_map
    content {
      cidr_block         = route.value.cidr_block
      gateway_id         = route.value.gateway_id
      nat_gateway_id     = route.value.nat_gateway_id
      vpc_endpoint_id    = route.value.vpc_endpoint_id
      transit_gateway_id = route.value.transit_gateway_id
    }
  }

  tags = {
    Name = "${var.env}-${var.name}-public-rt-${each.value.az}"
  }
}

resource "aws_route_table_association" "public" {
  for_each = var.public_subnets

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public[each.key].id
}
