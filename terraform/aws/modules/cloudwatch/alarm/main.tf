resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name                = "${var.env}-${var.name}-${var.role}-cw-alarm"
  comparison_operator       = var.comparison_operator
  evaluation_periods        = var.evaluation_periods
  metric_name               = var.metric_name
  namespace                 = var.namespace
  period                    = var.period
  statistic                 = var.statistic
  threshold                 = var.threshold
  alarm_actions             = var.alarm_actions
  insufficient_data_actions = var.insufficient_data_actions
  tags = {
    Name = "${var.env}-${var.name}-${var.role}-cw-alarm"
  }
}
