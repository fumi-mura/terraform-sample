resource "aws_identitystore_user" "this" {
  for_each = toset(var.users)

  identity_store_id = var.ssoadmin_instances_identity_store_ids
  user_name         = each.key # Use signin. can't change after.
  display_name      = each.key

  name {
    given_name  = each.key
    family_name = "user"
  }

  emails {
    value   = "${var.email}+${var.env}-${each.key}@gmail.com"
    primary = true
  }
}
