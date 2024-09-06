# This is My infra portfolio

## Directory structure

このリポジトリではパターンaを採用する。
リソースが少ない場合はパターンbや、env以下のファイルも単一のmain.tfにまとめてもよい。

選定基準はtfstateファイルをどの単位で分割するかによる。
1つのstateファイルで管理するリソースが増えると、target指定をしないplan/applyの実行に時間が増える。
分割しすぎると書く時に辛くなるが、リソースが増えるほどに効果は大きくなる。

### pattern a

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

### pattern b

```sh
.
├── environments/ # リソースが少ない場合はmain.tfにまとめてもOK
│   ├── ecs.tf
│   └── ecr.tf
└── modules/
    ├── ecs/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── ecr/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```
