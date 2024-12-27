resource "aws_eip" "this" {
  tags = {
    Name = var.eip_name
  }
}
