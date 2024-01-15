output "execution_role_arn" {
  value = aws_iam_role.ecs_execution_role.arn
  description = "The ARN of the ECS execution role"
}
