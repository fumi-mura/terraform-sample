# This is my infra portfolio

## System configuration chart

todo

## Directory structure

Pattern A is adopted in this repository.
Pattern B used if resources are few, or files under env can be combined into a single main.tf file.
The selection criterion depends on which unit the tfstate file is divided into.
The more resources are managed in one state file, the longer the execution time when plan/apply, etc. without specifying a target.
Too much division makes it hard to write source code, but the more resources you have, the greater the benefit.

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
│   │   ├── ecr.tf # If resources are few,  together them in main.tf is ok.
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

## Rules

### AWS resource name

{env}-{service_name}-{purpose}-{resource_name}  
ex: mng-fumis-portfolio-terraform-tfstate-s3-bucket


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
- SSM Parameter Store
  - ${email_local_pert} added manually

## Tools

- tfenv
- tflint
- tfsec
- Terragrunt
- terraform-docs
- Infracost
- direnv
- draw.io

## Static Analysis

### TFLint

```sh
infra_portfolio $ tflint --recursive --format compact
# The error below appears in the module. Ignore it ok because it is specified on the use side. (Even if set the disable setting in tflint.hcl, the error appears...)
# terraform_required_providers, terraform_required_version
```
