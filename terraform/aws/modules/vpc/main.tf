# 初回実行でDefault VPCをTerraform管理下に取り入れる
resource "aws_default_vpc" "this" {
  force_destroy = true # 関連りソースを削除することを許可
}
