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
            "repo:fumi-mura/terraform-sample:*",
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
  account_names = ["prd01"] # 過去に作成したメールアドレスが残っていてエラーになるため環境名に数字を追加している
  ou_name       = "prod"
}

module "sdlc_organizations" {
  source        = "../../modules/organizations"
  email         = data.aws_ssm_parameter.this.value
  account_names = ["dev01"] # 過去に作成したメールアドレスが残っていてエラーになるため環境名に数字を追加している
  ou_name       = "sdlc"
}

# IIC
module "iam_identity_center" {
  source                = "../../modules/iic"
  env                   = local.env
  name                  = local.name
  email                 = data.aws_ssm_parameter.this.value
  users                 = local.users
  groups                = local.groups
  user_group_membership = local.user_group_membership
  permission_sets       = local.permission_sets
  assignment_map        = local.assignment_map
}
