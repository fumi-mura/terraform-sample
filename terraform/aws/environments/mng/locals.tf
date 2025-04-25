data "aws_caller_identity" "current" {}

locals {
  env  = "mng"
  name = "fumis-pf"
}

locals {
  users = {
    Admin = {
      name = {
        family_name = "Admin"
        given_name  = "Admin"
      }
    }
    ReadOnly = {
      name = {
        family_name = "ReadOnly"
        given_name  = "ReadOnly"
      }
    }
  }
}
