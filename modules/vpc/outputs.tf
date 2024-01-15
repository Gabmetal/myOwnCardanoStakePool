output "vpc_id" {
  value       = aws_vpc.cardano_vpc.id
  description = "The ID of the VPC"
}

output "public_subnet_ids" {
  value       = [aws_subnet.public_subnet.id]
  description = "List of IDs of public subnets"
}

output "private_subnet_ids" {
  value       = [aws_subnet.private_subnet.id]
  description = "List of IDs of private subnets"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.igw.id
  description = "The ID of the Internet Gateway"
}

output "nat_gateway_id" {
  value       = aws_nat_gateway.nat_gw.id
  description = "The ID of the NAT Gateway"
}

output "relay_security_group_id" {
  value       = aws_security_group.relay_sg.id
  description = "The ID of the security group for the relay node"
}

output "producer_security_group_id" {
  value       = aws_security_group.producer_sg.id
  description = "The ID of the security group for the block producer node"
}
