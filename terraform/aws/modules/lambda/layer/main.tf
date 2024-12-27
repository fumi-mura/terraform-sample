resource "aws_lambda_layer_version" "this" {
  layer_name          = var.layer_name
  filename            = "${path.module}/zip_files/${var.filename}"
  compatible_runtimes = var.compatible_runtimes
}
