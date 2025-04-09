data "aws_caller_identity" "current" {}

locals {
  env  = "mng"
  name = "fumis-pf"
}
