resource "aws_sns_topic" "this" {
  name = var.topic_name
  tags = {
    Name = var.topic_name
  }
}

resource "aws_sns_topic_policy" "this" {
  arn    = aws_sns_topic.this.arn
  policy = jsonencode(var.topic_policy)
}
