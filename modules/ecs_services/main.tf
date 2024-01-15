# En modules/ecs_services/main.tf

resource "aws_ecs_service" "ecs_service" {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = var.task_definition
  launch_type     = "FARGATE" # O "EC2", según la configuración de tus tareas

  desired_count   = var.desired_count
  network_configuration {
    subnets         = var.subnet_ids
    security_groups = var.security_group_ids
  }
}
