data "aws_organizations_organization" "this" {}

data "aws_ssm_parameter" "this" {
  name = "email_local_pert"
}

module "identity_center" {
  source            = "../../../modules/identity_center"
  env               = local.env
  name              = local.name
  master_account_id = data.aws_organizations_organization.this.master_account_id
  email_local_pert  = data.aws_ssm_parameter.this.value
}
