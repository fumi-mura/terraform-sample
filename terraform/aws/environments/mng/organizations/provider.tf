provider "aws" {
  default_tags {
    tags = {
      Environment        = local.env
      ServiceName        = local.name
      ManagedByTerraform = true
    }
  }
}
