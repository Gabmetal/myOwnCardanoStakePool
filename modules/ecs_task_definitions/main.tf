resource "aws_ecs_task_definition" "cardano_task" {
  for_each = {for idx, task in var.tasks : idx => task}

  family                   = each.value.family
  network_mode             = "awsvpc"
  requires_compatibilities = [each.value.task_compatibilities]
  cpu                      = each.value.task_cpu
  memory                   = each.value.task_memory
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([{
    name         = each.value.container_name
    image        = each.value.container_image
    cpu          = each.value.container_cpu
    memory       = each.value.container_memory
    portMappings = each.value.container_port_mappings
    environment  = each.value.container_environment
    mountPoints  = each.value.container_mount_points
  }])

  volume {
    name = each.value.volume_name

    efs_volume_configuration {
      file_system_id         = var.efs_file_system_id
      root_directory         = var.efs_root_directory
      transit_encryption     = "ENABLED"
      transit_encryption_port = 2999
    }
  }
}
