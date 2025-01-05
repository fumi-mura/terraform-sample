# Refer to root account
data "aws_organizations_organization" "main" {}

resource "aws_organizations_organizational_unit" "this" {
  name      = var.ou_name
  parent_id = data.aws_organizations_organization.main.roots[0].id
}

# Make account
resource "aws_organizations_account" "this" {
  for_each = toset(var.account_names)

  name              = each.key
  email             = "381704fumi+${each.key}@gmail.com"
  parent_id         = aws_organizations_organizational_unit.this.id
  close_on_deletion = true
}
