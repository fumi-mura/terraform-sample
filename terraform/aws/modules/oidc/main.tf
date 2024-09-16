resource "aws_iam_openid_connect_provider" "this" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["0123456789012345678901234567890123456789"] # ref: https://github.com/aws-actions/configure-aws-credentials/issues/357#issuecomment-1626357333
}

resource "aws_iam_role" "oidc" {
  name = "${var.env}-${var.name}-oidc-iam-role"
  assume_role_policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Principal = {
            Federated = "${aws_iam_openid_connect_provider.this.arn}"
          },
          Action = "sts:AssumeRoleWithWebIdentity",
          Condition = {
            StringEquals = {
              "token.actions.githubusercontent.com:aud" : "sts.amazonaws.com"
            },
            StringLike = {
              "token.actions.githubusercontent.com:sub" : "repo:Fumi-Mura/infra_portfolio:*"
            }
          }
        }
      ]
    }
  )
}

resource "aws_iam_policy" "oidc" {
  name = "${var.env}-${var.name}-oidc-iam-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["*"]
        Resource = ["*"]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "oidc" {
  role       = aws_iam_role.oidc.name
  policy_arn = aws_iam_policy.oidc.arn
}
