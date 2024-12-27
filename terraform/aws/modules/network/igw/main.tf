resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.env}-${var.name}-igw-rt"
  }
}

resource "aws_route_table_association" "igw" {
  route_table_id = aws_route_table.igw.id
  gateway_id     = aws_internet_gateway.this.id
}
