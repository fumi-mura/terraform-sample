module "organizations" {
  source = "../../modules/organizations"
}

module "identity_center" {
  source            = "../../modules/identity_center"
  env               = local.env
  master_account_id = module.organizations.master_account_id
  email_local_pert  = var.email_local_pert
}
