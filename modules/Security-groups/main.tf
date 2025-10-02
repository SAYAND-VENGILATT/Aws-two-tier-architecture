#RDS SECURITY GROUP
resource "aws_security_group" "RDS" {
    name = "rds_sg"
    description = "Security group for RDS"
    vpc_id = var.vpc_id
   
   ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.webserver.id]
  }
   egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   }
  
}

#EC2 SECURITY GROUP
resource "aws_security_group" "ec2" {
  name   = "ec2-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.ALB.id]
  }
  egress {
     from_port = 0
     to_port = 0
     protocol = "-1"
     cidr_blocks = ["0.0.0.0/0"]
  }
}
#ALB SECURITY GROUP
resource "aws_security_group" "ALB" {
  name = "ALB-sg"
  description = "security group for ALB"
  vpc_id = var.vpc_id
  
  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

   egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   }
}

#WEBSERVER SECURITY GROUP
resource "aws_security_group" "webserver" {
  name = "web_sg"
  description = "Security group for webserver"
  vpc_id = var.vpc_id

 ingress {
    description = "HTTP from ALB"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.ALB.id]
  }

 ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

 egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
}
