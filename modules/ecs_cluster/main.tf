resource "aws_ecs_cluster" "cardano_cluster" {
  name = var.cluster_name
}
