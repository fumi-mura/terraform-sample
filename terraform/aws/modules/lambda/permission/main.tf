resource "aws_lambda_permission" "this" {
  function_name = var.function_name
  action        = "lambda:InvokeFunction"
  statement_id  = var.statement_id
  principal     = var.principal
  source_arn    = var.source_arn
}
