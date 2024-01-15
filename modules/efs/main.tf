resource "aws_efs_file_system" "cardano_fs" {
  performance_mode    = "generalPurpose"
  throughput_mode     = "bursting"
  encrypted           = true

  tags = {
    Name = var.efs_name
  }
}
