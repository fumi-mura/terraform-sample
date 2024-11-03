resource "aws_cloudwatch_log_group" "this" {
  name              = "${var.prefix}/${var.env}-${var.name}-${var.role}-cw-log"
  retention_in_days = var.retention_in_days

  tags = {
    Name = "${var.env}-${var.name}-${var.role}-cw-log"
  }
}
