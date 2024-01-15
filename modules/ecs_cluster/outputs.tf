output "cluster_id" {
  value       = aws_ecs_cluster.cardano_cluster.id
  description = "The ID of the ECS cluster"
}

output "cluster_arn" {
  value       = aws_ecs_cluster.cardano_cluster.arn
  description = "The ARN of the ECS cluster"
}
