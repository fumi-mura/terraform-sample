# OIDC
module "oidc_provider" {
  source = "../../modules/iam/oidc"
}

module "oidc_iam_role" {
  source               = "../../modules/iam/role"
  env                  = local.env
  name                 = local.name
  role                 = "oidc"
  managed_policy_arns  = [module.oidc_iam_policy.iam_policy_arn]
  max_session_duration = 3600
  policy_statement = {
    1 = {
      effect  = "Allow"
      actions = ["sts:AssumeRoleWithWebIdentity"]
      principals = [{
        type        = "Federated"
        identifiers = ["${module.oidc_provider.oidc_arn}"]
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
            "repo:Fumi-Mura/infra_portfolio:*",
          ]
      }]
    }
  }
}

module "oidc_iam_policy" {
  source = "../../modules/iam/policy"
  env    = local.env
  name   = local.name
  role   = "oidc"
  policy_statement = {
    1 = {
      effect    = "Allow"
      actions   = ["*"]
      resources = ["*"]
      condition = []
    }
  }
}

# IAM Identity Center
data "aws_organizations_organization" "this" {}

data "aws_ssm_parameter" "this" {
  name = "email_local_pert"
}

module "identity_center" {
  source            = "../../modules/identity_center"
  env               = local.env
  name              = local.name
  master_account_id = data.aws_organizations_organization.this.master_account_id
  email_local_pert  = data.aws_ssm_parameter.this.value
}

# Organizations
module "organizations" {
  source = "../../modules/organizations"
}
