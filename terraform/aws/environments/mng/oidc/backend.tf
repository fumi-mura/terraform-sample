terraform {
  backend "s3" {
    bucket = "mng-fumis-portfolio-terraform-tfstate-s3-bucket"
    key    = "oidc/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
