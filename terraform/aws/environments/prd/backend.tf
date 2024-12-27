terraform {
  backend "s3" {
    bucket = "prd-fumis-portfolio-terraform-tfstate-s3-bucket"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}
