# OIDC
module "oidc_provider" {
  source = "../../modules/iam/oidc"
}

module "oidc_iam_role" {
  source               = "../../modules/iam/role"
  iam_role_name        = "${local.env}-${local.name}-oidc-iam-role"
  managed_policy_arns  = [module.oidc_iam_policy.iam_policy_arn]
  max_session_duration = 3600
  policy_statement = {
    1 = {
      effect  = "Allow"
      actions = ["sts:AssumeRoleWithWebIdentity"]
      principals = [{
        type        = "Federated"
        identifiers = [module.oidc_provider.oidc_arn]
      }]
      condition = [{
        test     = "StringEquals"
        variable = "token.actions.githubusercontent.com:aud"
        values   = ["sts.amazonaws.com"]
        },
        {
          test     = "StringLike"
          variable = "token.actions.githubusercontent.com:sub"
          values = [
            "repo:fumi-mura/infra_portfolio:*",
          ]
      }]
    }
  }
}

module "oidc_iam_policy" {
  source          = "../../modules/iam/policy"
  iam_policy_name = "${local.env}-${local.name}-oidc-iam-policy"
  policy_statement = {
    1 = {
      effect    = "Allow"
      actions   = ["*"]
      resources = ["*"]
      condition = []
    }
  }
}

# SSM
data "aws_ssm_parameter" "this" {
  name = "email_local_pert"
}

# Organizations
module "prod_organizations" {
  source        = "../../modules/organizations"
  email         = data.aws_ssm_parameter.this.value
  account_names = ["prd01"] # 過去に作成したアドレスが残っていてエラーになるため環境名に数字を追加している
  ou_name       = "prod"
}

module "sdlc_organizations" {
  source        = "../../modules/organizations"
  email         = data.aws_ssm_parameter.this.value
  account_names = ["dev01"] # 過去に作成したアドレスが残っていてエラーになるため環境名に数字を追加している
  ou_name       = "sdlc"
}

# IAM Identity Center
module "iic_permission_set" {
  source = "../../modules/identity_center/permission_set"
  ssoadmin_instances_arn = module.iam_identity_center.ssoadmin_instances_arn
}

module "iic_user" {
  source = "../../modules/identity_center/user"
  env    = local.env
  users  = local.users
  email  = data.aws_ssm_parameter.this.value
  identity_store_id = module.iam_identity_center.identity_store_id
}

module "iam_identity_center" {
  source = "../../modules/identity_center"
  env    = local.env
  groups = local.groups
  name   = local.name
  # email  = data.aws_ssm_parameter.this.value
  member_id = {
    Admin = module.iic_user.user_id,
    ReadOnly = module.iic_user.ReadOnly_user_id,
  }
  principal_id = module.iic_user.user_id
  account_ids = [
    data.aws_caller_identity.current.account_id,
    module.prod_organizations.member_account_id[0],
    module.sdlc_organizations.member_account_id[0]
  ]

  permission_set_arn = module.iic_permission_set.permission_set_arn

  # account_assignments = {
  #   # 1 = {
  #   #   target_id          = data.aws_caller_identity.current.account_id,
  #   #   permission_set_arn = module.iic_permission_set.permission_set_arn
  #   #   principal_id       = module.iam_identity_center.user_id
  #   # }
  #   2 = {
  #     target_id          = module.prod_organizations.member_account_id[0]
  #     permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-775858b230c132be/ps-016128be1f0d2c70"
  #     principal_id       = "57344af8-5091-7024-7358-e523c32873a5"
  #   }
  #   # 3 = {
  #   #   target_id          = module.sdlc_organizations.member_account_id[0]
  #   #   permission_set_arn = module.iic_permission_set.permission_set_arn
  #   #   principal_id       = module.iam_identity_center.user_id
  #   # }
  # }
}
