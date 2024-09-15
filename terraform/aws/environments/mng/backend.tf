terraform {
  backend "s3" {
    bucket = "mng-s3-bucket-terraform-tfstate"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}
