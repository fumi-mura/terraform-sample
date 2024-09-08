# This is my infra portfolio

## System configuration chart

todo

## Directory structure

このリポジトリではパターンAを採用する。
リソースが少ない場合はパターンBや、env以下のファイルも単一のmain.tfにまとめてもOK。

選定基準はtfstateファイルをどの単位で分割するかによる。
1つのstateファイルで管理するリソースが増えると、target指定をしないplan/applyなどの実行時間が長くなる。
分割しすぎるとソースコードを書く時に辛くなるが、リソースが増えるほどに効果は大きくなる。

### Pattern A

```sh
.
├── ecr/
│   ├── dev/
│   │   └── main.tf
│   ├── stg
│   ├── prd
│   └── modules/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── ecs/
```

### Pattern B

```sh
.
├── environments/ # リソースが少ない場合はmain.tfにまとめてもOK
│   ├── ecr.tf
│   └── ecs.tf
└── modules/
    ├── ecr/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── ecs/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Setting local environment

todo

## Outside source code control

- S3 bucket for terraform.tfstate
  - If use CFn(terraform/aws/tfstate/s3.yml)

## Tools

- tfenv
- tflint
- tfsec
- direnv
- draw.io
