data "aws_caller_identity" "current" {}

locals {
  env  = "mng"
  name = "fumis-pf"
}

# IIC
locals {
  users = {
    Admin = {
      name = {
        family_name = "Admin"
        given_name  = "Admin"
      }
      groups = ["Admin"]
    }
    ReadOnly = {
      name = {
        family_name = "ReadOnly"
        given_name  = "ReadOnly"
      }
      groups = ["ReadOnly"]
    }
  }
  groups = {
    Admin = {
      name = "Admin"
    }
    ReadOnly = {
      name = "ReadOnly"
    }
  }

  users_groups_combined = [
    for user, user_data in local.users : {
      for group in user_data.groups :
      "${user}_${group}" => {
        "user"  = user
        "group" = group
      }
    }
  ]

  users_groups_membership = zipmap(
    flatten(
      [for item in local.users_groups_combined : keys(item)]
    ),
    flatten(
      [for item in local.users_groups_combined : values(item)]
    )
  )
}
