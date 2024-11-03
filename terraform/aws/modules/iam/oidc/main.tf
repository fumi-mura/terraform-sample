resource "aws_iam_openid_connect_provider" "this" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["0123456789012345678901234567890123456789"] # ref: https://github.com/aws-actions/configure-aws-credentials/issues/357#issuecomment-1626357333
}
