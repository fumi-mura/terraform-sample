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

module "test_1_cwlogs" {
  source      = "../../modules/cloudwatch/log"
  cwlogs_name = "test-1"
}

module "test_3_cwlogs" {
  source      = "../../modules/cloudwatch/log"
  cwlogs_name = "test-3"
}
