variable "execution_role_arn" {
  description = "The ARN of the task execution role"
  type        = string
}

variable "efs_file_system_id" {
  description = "The ID of the EFS file system"
  type        = string
}

variable "efs_root_directory" {
  description = "The root directory on the EFS file system"
  type        = string
}

variable "tasks" {
  description = "A list of task configurations"
  type = list(object({
    family                   = string
    task_compatibilities     = string
    task_cpu                 = string
    task_memory              = string
    container_name           = string
    container_image          = string
    container_cpu            = number
    container_memory         = number
    container_port_mappings  = list(any)
    container_environment    = list(any)
    volume_name              = string
    container_mount_points   = list(object({
      sourceVolume  = string
      containerPath = string
      readOnly      = bool
    }))
  }))
}

