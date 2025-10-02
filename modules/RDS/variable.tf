variable "private_subnets" {
    type = list(string)
}
variable "vpc_id"{
    description = "VPC ID"
    type = string
 }
variable "rds_sg_id"{
  description = "Security id for rds"
  type = string
}
variable "db_instance_class" {
  description = "RDS INSTANCE CLASS"
  type = string
}
variable "allocated_storage" {
  description = "RDS STORAGE IN GB"
  type = number
}
variable "db_username"{
  description = "USERNAME OF RDS"
  type = string
}
variable "db_password"{
  description = "PASSWORD OF RDS"
  type = string
}
variable "db_name" {
  description = "RDS DATABASE NAME"
  type = string
}