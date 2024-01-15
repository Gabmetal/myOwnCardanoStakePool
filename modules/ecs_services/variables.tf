# En modules/ecs_services/variables.tf

variable "service_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "cluster_id" {
  description = "The ID of the ECS cluster"
  type        = string
}

variable "task_definition" {
  description = "The task definition to use with the service"
  type        = string
}

variable "desired_count" {
  description = "The number of instances of the task to run"
  type        = number
}

variable "subnet_ids" {
  description = "The list of subnet IDs to launch tasks in"
  type        = list(string)
}

variable "security_group_ids" {
  description = "The list of security group IDs to associate with tasks"
  type        = list(string)
}
