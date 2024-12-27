output "cidr_block_a" {
  value = aws_subnet.public["a"].cidr_block
}

output "cidr_block_c" {
  value = aws_subnet.public["c"].cidr_block
}

output "subnet_id_a" {
  value = aws_subnet.public["a"].id
}

output "subnet_id_c" {
  value = aws_subnet.public["c"].id
}
