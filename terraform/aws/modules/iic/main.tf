data "aws_ssoadmin_instances" "this" {}

resource "aws_ssoadmin_permission_set" "this" {
  for_each = var.permission_sets

  name         = each.value.name
  description  = each.value.description
  instance_arn = tolist(data.aws_ssoadmin_instances.this.arns)[0]
}

resource "aws_ssoadmin_managed_policy_attachment" "this" {
  for_each = var.permission_sets

  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  managed_policy_arn = each.value.managed_policy_arn
  permission_set_arn = aws_ssoadmin_permission_set.this[each.key].arn
}

# User
resource "aws_identitystore_user" "this" {
  for_each = var.users

  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  display_name      = join(" ", [each.value.name.given_name, each.value.name.family_name])
  user_name         = each.key

  name {
    family_name = each.value["name"]["family_name"]
    given_name  = each.value["name"]["given_name"]
  }

  emails {
    value   = "${var.email}+${var.env}-${each.key}@gmail.com"
    primary = true
  }
}

# Group
resource "aws_identitystore_group" "this" {
  for_each = var.groups

  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  display_name      = each.value["name"]
  description       = each.value["description"]
}

# Attach user to group
resource "aws_identitystore_group_membership" "this" {
  for_each = var.user_group_membership

  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  group_id          = aws_identitystore_group.this[each.value["group"]].group_id
  member_id         = aws_identitystore_user.this[each.value["user"]].user_id
}

# Apply IIC settings to each account
resource "aws_ssoadmin_account_assignment" "this" {
  for_each = var.assignment_map

  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.this[each.value.permission_set].arn
  principal_id       = aws_identitystore_group.this[each.value.group].group_id
  principal_type     = "GROUP"
  target_id          = each.value.account_id
  target_type        = "AWS_ACCOUNT"
}
