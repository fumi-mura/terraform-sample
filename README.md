# This is my infra portfolio

## System configuration chart

todo

## Directory structure

このリポジトリではパターンAを採用する。リソースが少ない場合はパターンBや、env以下のファイルも単一のmain.tfにまとめてもOK。
選定基準はtfstateファイルをどの単位で分割するかによる。1つのstateファイルで管理するリソースが増えると、target指定をしないplan/applyなどの実行時間が長くなる。分割しすぎるとソースコードを書く時に辛くなるが、リソースが増えるほどに恩恵は大きくなる。

### Pattern A

```sh
.
├── environmets/
│   ├── dev/
│   │   ├── ecr/
│   │   │   ├── main.tf
│   │   │   ├── backend.tf
│   │   │   ├── provider.tf
│   │   │   └── terraform.tf
│   │   └── ecs/
│   ├── stg/
│   └── prd/
└── modules/
    ├── ecr/
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    └── ecs/
```

### Pattern B

```sh
.
├── environments/
│   ├── dev/
│   │   ├── ecr.tf # リソースが少ない場合はmain.tfにまとめてもOK
│   │   ├── ecs.tf
│   │   ├── backend.tf
│   │   ├── provider.tf
│   │   └── terraform.tf
│   ├── stg/
│   └── prd/
└── modules/
    ├── ecr/
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    └── ecs/
```

## Setting local environment

### If use IAM Identity Center

```sh
# The variable is passed from github secrets, so if you wanna run terraform from local, you need to include this variable in the tfvars file.
echo 'email_local_pert = "foo"' >> terraform/aws/environments/{env}/terraform.tfvars
```

## Outside source code control

- S3 bucket for terraform.tfstate
  - If use CFn(terraform/aws/tfstate/s3.yml)
- AWS Organizations
  - Enable Organizations
  - Terraform not yet supported
- IAM Identity Center
  - Enable IAM Identity Center
  - Enable sent OTP when Create UserAPI
  - Enable mfa
  - Sent verify Email(success sent email when manual make user...?)
  - Terraform not yet supported

## Tools

- tfenv
- tflint
- tfsec
- Terragrunt
- terraform-docs
- Infracost
- direnv
- draw.io
