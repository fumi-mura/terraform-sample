output "master_account_id" {
  value = data.aws_organizations_organization.main.master_account_id
}

output "member_account_id" {
  value = [for acct in aws_organizations_account.this : acct.id]
}
