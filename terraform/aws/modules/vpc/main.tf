# 初回実行でDefault VPCをTerraform管理下に取り入れる
resource "aws_default_vpc" "this" {
  force_destroy = true # 関連りソースを削除することを許可
}

# Delete default sg rule.
# If egress/ingress is not specified, delete sg rule.
resource "aws_default_security_group" "this" {
  vpc_id = aws_default_vpc.this.id
}
