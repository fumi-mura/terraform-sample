# AWSのアカウントIDを取得
data "aws_caller_identity" "this" {}

# 同じProviderは複数登録できないため、以下リソースをそれぞれのリポジトリ用のリソースから参照する
# 同じAWSアカウントに存在する環境はActions用のIAM Roleを共通で使用するため、dev02は本リソースを作成しない
resource "aws_iam_openid_connect_provider" "this" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  # GitHubとAWS間でよしなにやるのでユーザ側で証明書をpinする必要はなく、適当なダミー値を入れておけばOK
  # 参考 https://github.com/aws-actions/configure-aws-credentials/issues/357#issuecomment-1626357333
  thumbprint_list = ["0123456789012345678901234567890123456789"]
}

resource "aws_iam_role" "oidc" {
  name               = "${var.env}-${var.name}-oidc-iam-role"
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
              "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
            },
            StringLike = {
              # リポジトリを指定して認証を許可
              "token.actions.githubusercontent.com:sub": "repo:Fumi-Mura/infra_portfolio:*"
            }
          }
        }
      ]
    }
  )
}

resource "aws_iam_policy" "oidc" {
  name     = "${var.env}-${var.name}-oidc-iam-policy"
  policy   = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = ["*"]
        Resource  = ["*"]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "oidc" {
  role       = aws_iam_role.oidc.name
  policy_arn = aws_iam_policy.oidc.arn
}
