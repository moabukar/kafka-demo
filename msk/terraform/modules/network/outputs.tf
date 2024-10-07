output "vpc_id" {
  description = "VPC ID where MSK is deployed"
  value       = aws_vpc.msk_vpc.id
}

output "subnet_ids" {
  description = "Subnet IDs where MSK is deployed"
  value       = aws_subnet.msk_subnets[*].id
}

output "security_group_id" {
  description = "Security group for MSK cluster"
  value       = aws_security_group.msk_sg.id
}
