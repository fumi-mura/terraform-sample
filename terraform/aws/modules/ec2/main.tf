resource "aws_instance" "this" {
  ami                         = coalesce(var.ami, data.aws_ami.this.id)
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.sg_ids
  instance_type               = var.instance_type
  private_ip                  = var.private_ip
  key_name                    = var.key_name
  iam_instance_profile        = aws_iam_instance_profile.this.name
  associate_public_ip_address = false
  user_data                   = templatefile("${path.module}/scripts/user_data.sh", {})

  root_block_device {
    volume_size = 100
    volume_type = "gp3"

    tags = {
      Name = replace(var.ec2_name, "ec2", "ebs")
    }
  }

  tags = {
    Name = var.ec2_name
  }
}
