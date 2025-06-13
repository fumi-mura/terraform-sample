output "public_subnet_ids" {
  value = {
    for k, v in aws_subnet.public : k => v.id
  }
}

output "public_subnet_cidr_blocks" {
  value = {
    for k, v in aws_subnet.public : k => v.cidr_block
  }
}
