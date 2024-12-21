module "s3" {
  source = "../../modules/s3/bucket/"
  bucket_name = "${local.env}-${local.name}-test-s3-bucket"
}
