output "ssoadmin_instances_arn" {
  value = tolist(data.aws_ssoadmin_instances.this.arns)[0]
}
