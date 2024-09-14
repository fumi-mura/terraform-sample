# rootアカウントを参照
data "aws_organizations_organization" "main" {}

# アカウントの作成
resource "aws_organizations_account" "accounts" {
  for_each = toset(var.account_names)

  name     = each.key
  email    = "381704fumi+${each.key}@gmail.com"
  role_name = "OrganizationAccountAccessRole"
}

# resource "aws_organizations_organizational_unit" "example" {
#   name      = "example"
#   parent_id = aws_organizations_organization.main.roots[0].id
# }
