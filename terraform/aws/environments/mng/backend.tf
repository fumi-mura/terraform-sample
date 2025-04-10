terraform {
  backend "s3" {
    bucket = "mng-fumis-pf-terraform-tfstate-s3-bucket"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}
