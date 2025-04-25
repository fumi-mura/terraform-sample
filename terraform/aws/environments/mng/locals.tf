data "aws_caller_identity" "current" {}

locals {
  env  = "mng"
  name = "fumis-pf"
}

locals {
  account_ids = {
    mng = "${data.aws_caller_identity.current.account_id}",
    prd = "${module.prod_organizations.member_account_id[0]}",
    dev = "${module.sdlc_organizations.member_account_id[0]}"
  }

  # Users
  users = {
    # mng
    test-ichiro = {
      name = {
        family_name = "Test"
        given_name  = "Ichiro"
      }
      groups = ["mng_admin"]
    }
    # prd
    test-jiro = {
      name = {
        family_name = "Test"
        given_name  = "Jiro"
      }
      groups = ["dev_admin"]
    }
    # dev
    test-saburo = {
      name = {
        family_name = "Test"
        given_name  = "saburo"
      }
      groups = ["dev_admin"]
    }
  }

  # Groups
  groups = {
    # mng
    mng_admin = {
      name        = "mng-Administrator"
      description = "Administrator"
    }
    mng_readonly = {
      name        = "mng-Readonly"
      description = "Readonly"
    }
    # prd
    prd_admin = {
      name        = "prd-Administrator"
      description = "Administrator"
    }
    prd_readonly = {
      name        = "prd-Readonly"
      description = "Readonly"
    }
    # dev
    dev_admin = {
      name        = "dev-Administrator"
      description = "Administrator"
    }
    dev_readonly = {
      name        = "dev-Readonly"
      description = "Readonly"
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

  # Membership
  user_group_membership = zipmap(
    flatten(
      [for item in local.users_groups_combined : keys(item)]
    ),
    flatten(
      [for item in local.users_groups_combined : values(item)]
    )
  )

  # Permissions
  permission_sets = {
    admin = {
      name               = "AdministratorAccess"
      description        = "AdministratorAccess"
      managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
    },
    read_only = {
      name               = "ReadOnlyAccess"
      description        = "ReadOnlyAccess"
      managed_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
    }
  }

  # Account assignments
  account_assignments = [
    # mng
    {
      account_id     = local.account_ids.mng
      group          = "mng_admin"
      permission_set = "admin"
    },
    {
      account_id     = local.account_ids.mng
      group          = "mng_readonly"
      permission_set = "read_only"
    },
    # prd
    {
      account_id     = local.account_ids.prd
      group          = "prd_admin"
      permission_set = "admin"
    },
    {
      account_id     = local.account_ids.prd
      group          = "prd_readonly"
      permission_set = "read_only"
    },
    # dev
    {
      account_id     = local.account_ids.dev
      group          = "dev_admin"
      permission_set = "admin"
    },
    {
      account_id     = local.account_ids.dev
      group          = "dev_readonly"
      permission_set = "read_only"
    },
  ]

  assignment_map = {
    for a in local.account_assignments :
    format("%v-%v-%v", a.account_id, local.groups[a.group].name, local.permission_sets[a.permission_set].name) => a
  }
}
