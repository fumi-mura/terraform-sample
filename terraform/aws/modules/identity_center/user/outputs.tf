output "user_id" {
  value = aws_identitystore_user.this["Admin"].user_id
}

output "ReadOnly_user_id" {
  value = aws_identitystore_user.this["ReadOnly"].user_id
}

# output "principal_id" {
#   value = aws_identitystore_user.this["Admin"].user_id
# }
