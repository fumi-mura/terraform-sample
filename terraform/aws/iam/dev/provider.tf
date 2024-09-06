provider "aws" {
  default_tags {
    tags = {
      env = local.env
    }
  }
}
