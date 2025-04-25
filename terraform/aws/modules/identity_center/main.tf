data "aws_ssoadmin_instances" "this" {}

# Group
resource "aws_identitystore_group" "this" {
  for_each = var.groups

  display_name      = "${var.env}-${var.name}-${each.value["name"]}-iic-group"
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
}

# Attach user to group
resource "aws_identitystore_group_membership" "this" {
  for_each = var.member_id

  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  group_id          = aws_identitystore_group.this[each.key].group_id
  member_id         = each.value
}

# Apply IAM Identity Center (SSO) settings to each account
resource "aws_ssoadmin_account_assignment" "this" {
  for_each = toset(var.account_ids)

  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  permission_set_arn = var.permission_set_arn
  principal_id       = var.principal_id
  principal_type     = "USER"
  target_id          = each.value
  target_type        = "AWS_ACCOUNT"
}
