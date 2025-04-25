resource "aws_identitystore_user" "this" {
  for_each = var.users

  identity_store_id = var.identity_store_id
  user_name         = each.key # Use signin. can't change after.
  display_name      = "${each.value["name"]["given_name"]}-${each.value["name"]["family_name"]}"

  name {
    family_name = each.value["name"]["family_name"]
    given_name  = each.value["name"]["given_name"]
  }

  emails {
    value   = "${var.email}+${var.env}-${each.key}@gmail.com"
    primary = true
  }
}
