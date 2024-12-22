terraform {
  backend "s3" {
    bucket = "test-fumis-portfolio-terraform-tfstate-s3-bucket"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}
