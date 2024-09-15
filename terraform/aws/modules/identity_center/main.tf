data "aws_ssoadmin_instances" "this" {}

# 許可セットの作成
resource "aws_ssoadmin_permission_set" "this" {
  for_each = toset(var.permission_sets)

  instance_arn     = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  relay_state      = "https://ap-northeast-1.console.aws.amazon.com/console/home?region=ap-northeast-1" # Transition destination when session expires.
  name             = each.value                                                                         # Expected name length is 1-32.
  session_duration = "PT8H"
}

# 許可セットにpolicyをアタッチ
resource "aws_ssoadmin_managed_policy_attachment" "main" {
  for_each = aws_ssoadmin_permission_set.this

  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/${each.key}"
  permission_set_arn = each.value.arn
}

# Create user
resource "aws_identitystore_user" "this" {
  for_each = toset(var.create_users)

  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  user_name         = each.key # signinに使用、後から変更不可
  display_name      = each.key

  name {
    given_name  = each.key
    family_name = "user"
  }

  emails {
    value = "${var.email_local_pert}+${var.env}-${each.key}@gmail.com"
  }
}

# Create group
resource "aws_identitystore_group" "this" {
  for_each = toset(var.create_groups)

  display_name      = "${var.env}-${var.name}-iam-identity-center-group-${each.key}"
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
}

# Attach user to group
resource "aws_identitystore_group_membership" "this" {
  for_each = aws_identitystore_user.this

  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  group_id          = aws_identitystore_group.this[each.key].group_id
  member_id         = aws_identitystore_user.this[each.key].user_id
}


# 各アカウントにIAM Identity Center (SSO)の設定を適用
resource "aws_ssoadmin_account_assignment" "this" {
  # for_each           = aws_organizations_account.accounts
  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.this["AdministratorAccess"].arn
  principal_id       = aws_identitystore_user.this["Admin"].user_id # 設定するユーザーのID
  principal_type     = "USER"
  target_id          = var.master_account_id
  target_type        = "AWS_ACCOUNT"
}
