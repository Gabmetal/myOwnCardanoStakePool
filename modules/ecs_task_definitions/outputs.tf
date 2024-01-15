output "relay_task_definition_arn" {
  value       = aws_ecs_task_definition.cardano_task[0].arn
  description = "The ARN of the ECS task definition for the relay node"
}

output "producer_task_definition_arn" {
  value       = aws_ecs_task_definition.cardano_task[1].arn
  description = "The ARN of the ECS task definition for the block producer node"
}
