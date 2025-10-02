resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "key" {
  key_name   = "key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}
resource "local_file" "private_key" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "key.pem"
  file_permission = "0400"
}
module "vpc" {
  source = "./modules/vpc"
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  vpc_cidr = var.vpc_cidr
  availability_zones = var.availability_zones
}

module "ec2" {
  source = "./modules/ec2"
  ami_id =data.aws_ami.amazon_linux.id
  public_subnets = module.vpc.public_subnets
  instance_type = var.instance_type
  ec2_sg_id = module.security_groups.web_sg_id
   
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]  # AWS owned

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}
module "autoscaling" {
  source        = "./modules/autoscaling"
  ami_id        = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  ec2_sg_id     = module.security_groups.ec2_sg_id
  subnets       = module.vpc.private_subnets  
  target_group_arns = module.alb.target_group_arns
  
  # Optional parameters with defaults
  name_prefix      = "web-app"
  desired_capacity = 2
  min_size         = 1
  max_size         = 4
 
  
}
module "rds" {
  source = "./modules/rds"
 vpc_id=module.vpc.vpc_id
 db_username = var.db_username
 db_password = var.db_password
 allocated_storage = var.allocated_storage
 db_instance_class = var.db_instance_class
 private_subnets =  module.vpc.private_subnet_ids
 db_name = var.db_name
 rds_sg_id = module.security_groups.rds_sg_id
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  alb_name = var.alb_name
  target_grp_name = var.target_grp_name
  alb_sg_id = module.security_groups.alb_sg_id
}

module "security_groups" {
  source = "./modules/Security-groups"
  vpc_id = module.vpc.vpc_id
  vpc_cidr = module.vpc.vpc_cidr
  rds_sg_id = module.security_groups.rds_sg_id
}

module "cloudwatch" {
  source  = "./modules/cloudwatch"
  asg_name = module.autoscaling.asg_name
  rds_instance_id = module.rds.db_instance_id
}