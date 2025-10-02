output "rds_sg_id" {
  description = "DATABASE security group ID"
  value = aws_security_group.RDS.id
}
output "alb_sg_id" {
  description = "ALB security group ID"
  value = aws_security_group.ALB.id
}
output "web_sg_id" {
  description = "WEBSERVER security group ID"
  value = aws_security_group.webserver.id
}
output "ec2_sg_id"{
    description = "EC2 security group ID"
    value = aws_security_group.ec2.id

}