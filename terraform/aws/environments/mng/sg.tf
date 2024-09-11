module "default_sg" {
  source         = "../../modules/sg"
  default_vpc_id = module.default_vpc.default_vpc_id
}
