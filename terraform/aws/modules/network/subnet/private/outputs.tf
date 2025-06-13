output "private_subnet_ids" {
  value = {
    for k, v in aws_subnet.private : k => v.id
  }
}

output "private_subnet_cidr_blocks" {
  value = {
    for k, v in aws_subnet.private : k => v.cidr_block
  }
}
