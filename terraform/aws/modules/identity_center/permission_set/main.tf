resource "aws_ssoadmin_permission_set" "this" {
  for_each = toset(var.permission_sets)

  instance_arn     = var.ssoadmin_instances_arn
  relay_state      = "https://ap-northeast-1.console.aws.amazon.com/console/home?region=ap-northeast-1" # Transition destination when session expires.
  name             = each.value                                                                         # Expected name length is 1-32.
  session_duration = "PT8H"
}

resource "aws_ssoadmin_managed_policy_attachment" "this" {
  for_each = aws_ssoadmin_permission_set.this

  instance_arn       = var.ssoadmin_instances_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/${each.key}"
  permission_set_arn = each.value.arn
}
