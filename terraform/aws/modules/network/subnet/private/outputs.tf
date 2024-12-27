output "private_subnet_a" {
  value = aws_subnet.private["a"].id
}

output "private_subnet_c" {
  value = aws_subnet.private["c"].id
}
