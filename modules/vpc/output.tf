output "vpc_id" {
  value = aws_vpc.my_vpc.id
}
output "vpc_cidr" {
  value = aws_vpc.my_vpc.cidr_block
  
}
output "public_subnets" {
  value = [for subnet in aws_subnet.public_subnets : subnet.id]
}
output "private_subnets" {
  value = [for subnet in aws_subnet.private_subnets : subnet.id]
}
output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private_subnets[*].id
}