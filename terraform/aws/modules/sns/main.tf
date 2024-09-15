resource "aws_sns_topic" "this" {
  name = "${var.env}-${var.name}-sns-topic-${var.sns_name}"
  tags = {
    Name = "${var.env}-${var.name}-sns-topic-${var.sns_name}"
  }
}

resource "aws_sns_topic_policy" "this" {
  arn    = aws_sns_topic.this.arn
  policy = jsonencode(var.sns_policy)
}

resource "aws_sns_topic_subscription" "this" {
  topic_arn = aws_sns_topic.this.policy
  protocol  = var.sns_protocol
  endpoint  = var.sns_endpoint
}

resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  principal     = "sns.amazonaws.com"
  function_name = var.function_name
  source_arn    = aws_sns_topic.this.arn
}
