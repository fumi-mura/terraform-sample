resource "aws_sns_topic_subscription" "this" {
  topic_arn = var.sns_topic_arn
  protocol  = var.sns_protocol
  endpoint  = var.sns_endpoint
}
