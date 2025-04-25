output "ssoadmin_instances_arn" {
  value = tolist(data.aws_ssoadmin_instances.this.arns)[0]
}

output "ssoadmin_instances_identity_store_ids" {
  value = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
}
