# En modules/ecs_services/outputs.tf

output "service_id" {
  value       = aws_ecs_service.ecs_service.id
  description = "The ID of the ECS service"
}

output "service_name" {
  value       = aws_ecs_service.ecs_service.name
  description = "The name of the ECS service"
}
