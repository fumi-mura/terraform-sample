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

# VPC
module "vpc" {
  source   = "../../modules/network/vpc"
  vpc_name = "${local.env}-pluralith-vpc"
  vpc_cidr = "10.0.0.0/16"
}

# Internet Gateway
module "igw" {
  source   = "../../modules/network/igw"
  env      = local.env
  name     = "pluralith"
  vpc_id   = module.vpc.vpc_id
  igw_name = "${local.env}-igw"
}

# Public Subnets
module "public_subnet" {
  source = "../../modules/network/subnet/public"
  env    = local.env
  name   = "pluralith"
  vpc_id = module.vpc.vpc_id
  public_subnets = {
    "1a" = {
      cidr = "10.0.1.0/24"
      az   = "1a"
    }
    "1c" = {
      cidr = "10.0.2.0/24"
      az   = "1c"
    }
  }
  public_route_map = {
    "default" = {
      cidr_block         = "0.0.0.0/0"
      gateway_id         = module.igw.igw_id
      nat_gateway_id     = ""
      vpc_endpoint_id    = ""
      transit_gateway_id = ""
    }
  }
}

# Elastic IP for NAT Gateway
module "eip" {
  source   = "../../modules/network/eip"
  eip_name = "${local.env}-pluralith-nat-eip"
}

# NAT Gateway
module "nat" {
  source        = "../../modules/network/nat"
  ngw_name      = "${local.env}-pluralith-nat"
  allocation_id = module.eip.allocation_id
  subnet_id     = module.public_subnet.public_subnet_ids["1a"]
}

# Private Subnets
module "private_subnet" {
  source = "../../modules/network/subnet/private"
  env    = local.env
  name   = "pluralith"
  vpc_id = module.vpc.vpc_id
  private_subnets = {
    "1a" = {
      cidr = "10.0.10.0/24"
      az   = "1a"
    }
    "1c" = {
      cidr = "10.0.20.0/24"
      az   = "1c"
    }
  }
  private_route_map = {
    "default" = {
      cidr_block         = "0.0.0.0/0"
      nat_gateway_id     = module.nat.nat_gateway_id
      vpc_endpoint_id    = ""
      transit_gateway_id = ""
    }
  }
}

# Security Group
module "sg" {
  source = "../../modules/sg"
  sg_name = "${local.env}-pluralith-sg"
  vpc_id = module.vpc.vpc_id
  ingress_rule_map = {
    "ssh" = {
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      cidr_ipv4   = "10.0.0.0/16"
      description = "SSH access from VPC"
    }
  }
  egress_rule_map = {
    "all" = {
      from_port   = 0
      to_port     = 0
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
      description = "All outbound traffic"
    }
  }
}

# IAM Role for EC2
module "ec2_iam_role" {
  source               = "../../modules/iam/role"
  iam_role_name        = "${local.env}-pluralith-ec2-iam-role"
  managed_policy_arns  = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  max_session_duration = 3600
  policy_statement = {
    1 = {
      effect  = "Allow"
      actions = ["sts:AssumeRole"]
      principals = [{
        type        = "Service"
        identifiers = ["ec2.amazonaws.com"]
      }]
      condition = []
    }
  }
}

# EC2 Instance
module "ec2" {
  source                  = "../../modules/ec2"
  ami                    = ""
  ec2_name               = "${local.env}-pluralith-ec2"
  subnet_id              = module.private_subnet.private_subnet_ids["1a"]
  sg_ids                 = [module.sg.sg_id]
  instance_type          = "t3.micro"
  private_ip             = "10.0.10.10"
  key_name               = ""
  instance_profile_name  = "${local.env}-ec2-instance-profile"
  iam_role_name          = module.ec2_iam_role.iam_role_name
}
