# Refer to root account
data "aws_organizations_organization" "this" {}

resource "aws_organizations_organizational_unit" "this" {
  name      = var.ou_name
  parent_id = data.aws_organizations_organization.this.roots[0].id
}

# Make account
resource "aws_organizations_account" "this" {
  for_each = toset(var.account_names)

  name              = each.key
  email             = "${var.email}+${each.key}@gmail.com"
  parent_id         = aws_organizations_organizational_unit.this.id
  close_on_deletion = true
}
