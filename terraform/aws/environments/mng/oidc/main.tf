module "oidc" {
  source = "../../../modules/oidc"
  env    = local.env
  name   = local.name
}
