# module "organizations" {
#   source = "../../modules/organizations"
# }

# module "identity_center" {
#   source            = "../../modules/identity_center"
#   env               = local.env
#   name              = local.name
#   master_account_id = module.organizations.master_account_id
#   email_local_pert  = module.ssm.email_local_pert
# }

# module "ssm" {
#   source = "../../modules/ssm"
# }

# module "oidc" {
#   source = "../../modules/oidc"
#   env    = local.env
#   name   = local.name
# }

# module "default_vpc" {
#   source = "../../modules/vpc"
# }
