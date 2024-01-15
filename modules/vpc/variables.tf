variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "public_subnet_az" {
  description = "Availability zone for the public subnet"
  type        = string
}

variable "public_subnet_name" {
  description = "Name tag for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "private_subnet_az" {
  description = "Availability zone for the private subnet"
  type        = string
}

variable "private_subnet_name" {
  description = "Name tag for the private subnet"
  type        = string
}

variable "igw_name" {
description = "Name tag for the Internet Gateway"
type = string
}

variable "nat_gw_name" {
description = "Name tag for the NAT Gateway"
type = string
}

variable "relay_sg_name" {
description = "Name for the security group of the relay node"
type = string
}

variable "producer_sg_name" {
description = "Name for the security group of the block producer node"
type = string
}