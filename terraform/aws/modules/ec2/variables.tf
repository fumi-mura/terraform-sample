variable "ami" {
  type        = string
  description = "Default is created from latest Amazon Linux 2."
}

variable "ec2_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "sg_ids" {
  type = list(string)
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "private_ip" {
  type = string
}

variable "key_name" {
  type = string
}

variable "instance_profile_name" {
  type = string
}

variable "iam_role_name" {
  type = string
}
