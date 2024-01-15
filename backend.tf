terraform {
  cloud {
    organization = "gabmetal"
    workspaces {
      name = "cardano-stake-pool"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.32.1"
    }
  }
}