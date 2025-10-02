output "db_instance_id" {
  value = aws_db_instance.db_instance.id
}
output "db_endpoint" {
  description = "DATABASE ENDPOINT"
  value= aws_db_instance.db_instance.endpoint
}
output "db_port" {
  description = "DATABASE PORT"
  value = aws_db_instance.db_instance.port
}
output "db_name" {
    description = "DATABASE USERNAME"
    value = aws_db_instance.db_instance.db_name
    sensitive = true  
}