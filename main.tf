module "cardano_network" {
  source = "./modules/vpc"

  vpc_cidr_block      = "10.0.0.0/16"
  vpc_name            = "CardanoVPC"
  public_subnet_cidr  = "10.0.1.0/24"
  public_subnet_az    = "us-east-1a"
  public_subnet_name  = "CardanoPublicSubnet"
  private_subnet_cidr = "10.0.2.0/24"
  private_subnet_az   = "us-east-1b"
  private_subnet_name = "CardanoPrivateSubnet"
  igw_name            = "CardanoIGW"
  nat_gw_name         = "CardanoNAT"
  relay_sg_name       = "CardanoRelaySG"
  producer_sg_name    = "CardanoProducerSG"
}

module "iam" {
  source    = "./modules/iam"
  role_name = "ecs-execution-role"
}

module "efs" {
  source   = "./modules/efs"
  efs_name = "CardanoEFS"
}

module "ecs_cluster" {
  source       = "./modules/ecs_cluster"
  cluster_name = "cardano-cluster"
}

module "ecs_task_definitions" {
  source             = "./modules/ecs_task_definitions"
  execution_role_arn = module.iam.execution_role_arn
  efs_file_system_id = module.efs.efs_id
  efs_root_directory = "/"

  tasks = [
    {
      family               = "cardano-relay"
      task_compatibilities = "FARGATE"
      task_cpu             = "2048"
      task_memory          = "4096"
      container_name       = "cardano-relay"
      container_image      = "arradev/cardano-node:latest"
      container_cpu        = 1024
      container_memory     = 2048
      container_port_mappings = [
        {
          containerPort = 3000,
          hostPort      = 3000,
          protocol      = "tcp"
        },
        {
          containerPort = 12798,
          hostPort      = 12798,
          protocol      = "tcp"
        }
      ]
      container_environment = [
        {
          name  = "NODE_PORT",
          value = "3000"
        },
        {
          name  = "NODE_NAME",
          value = "relay1"
        },
        {
          name  = "CARDANO_NETWORK",
          value = "main"
        },
        {
          name  = "PROMETHEUS_PORT",
          value = "12798"
        }
      ]
      volume_name = "cardano-data"
      container_mount_points = [
        {
          sourceVolume  = "cardano-data",
          containerPath = "/data",
          readOnly      = false
        }
      ]
    },
    {
      family               = "cardano-producer"
      task_compatibilities = "FARGATE"
      task_cpu             = "2048"
      task_memory          = "4096"
      container_name       = "cardano-producer"
      container_image      = "arradev/cardano-node:latest"
      container_cpu        = 1024
      container_memory     = 2048
      container_port_mappings = [
        {
          containerPort = 12798,
          hostPort      = 12798,
          protocol      = "tcp"
        }
      ]
      container_environment = [
        {
          name  = "NODE_NAME",
          value = "producer1"
        },
        {
          name  = "CARDANO_NETWORK",
          value = "main"
        },
        {
          name  = "PROMETHEUS_PORT",
          value = "12798"
        }
      ]
      volume_name = "cardano-data"
      container_mount_points = [
        {
          sourceVolume  = "cardano-data",
          containerPath = "/data",
          readOnly      = false
        }
      ]
    }
  ]
}

# Servicio ECS para el nodo Relay
module "ecs_relay_service" {
  source             = "./modules/ecs_services"
  service_name       = "cardano-relay-service"
  cluster_id         = module.ecs_cluster.cluster_id
  task_definition    = module.ecs_task_definitions.relay_task_definition_arn
  desired_count      = 1
  subnet_ids         = module.cardano_network.public_subnet_ids
  security_group_ids = [module.cardano_network.relay_security_group_id]
}

# Servicio ECS para el nodo Productor de Bloques
module "ecs_producer_service" {
  source             = "./modules/ecs_services"
  service_name       = "cardano-producer-service"
  cluster_id         = module.ecs_cluster.cluster_id
  task_definition    = module.ecs_task_definitions.producer_task_definition_arn
  desired_count      = 1
  subnet_ids         = module.cardano_network.private_subnet_ids
  security_group_ids = [module.cardano_network.producer_security_group_id]
}
