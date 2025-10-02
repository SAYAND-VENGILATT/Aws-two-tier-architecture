resource "aws_db_instance" "db_instance" {
  db_name = var.db_name
  allocated_storage    = var.allocated_storage
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = var.db_instance_class
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.sg_grp.name
  vpc_security_group_ids = [var.rds_sg_id]
}

resource "aws_db_subnet_group" "sg_grp" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnets
}
