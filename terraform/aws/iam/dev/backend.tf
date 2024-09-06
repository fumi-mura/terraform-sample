terraform {
  backend "s3" {
    bucket = "dev-iam-terraform-tfstate"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}
