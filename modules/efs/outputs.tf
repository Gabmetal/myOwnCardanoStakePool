output "efs_id" {
  value       = aws_efs_file_system.cardano_fs.id
  description = "The ID of the EFS file system"
}
