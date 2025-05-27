data "archive_file" "this" {
  type        = "zip"
  source_dir  = "${path.module}/payload/${var.source_dir}"
  output_path = "./payload/${var.source_dir}.zip"
}

resource "aws_lambda_function" "this" {
  function_name    = var.funcion_name
  role             = var.role_arn
  filename         = data.archive_file.this.output_path
  source_code_hash = data.archive_file.this.output_base64sha256
  handler          = var.handler
  runtime          = var.runtime
  memory_size      = var.memory_size
  timeout          = var.timeout
  layers           = var.layers

  dynamic "environment" {
    for_each = length(keys(var.environment_variables)) == 0 ? 0 : 1
    content {
      variables = var.environment_variables
    }
  }

  tags = {
    Name = var.funcion_name
  }
}
