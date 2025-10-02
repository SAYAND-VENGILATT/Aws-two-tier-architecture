variable "region" {
    description = "AWS Region"
    default     = "us-east-1"
}

variable "instance_type" {
    description = "EC2 instance type"
    type        = string
    default     = "t3.micro"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_subnets" {
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
    default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
    type    = list(string)
    default = ["us-east-1a", "us-east-1b"]
}

variable "ami_id" {
    description = "AMI for ec2 instances"
    type        = string
    default     = "ami-0c02fb55956c7d316"  # Add a default AMI for us-east-1
}

# RDS VARIABLES
variable "db_instance_class" {
    description = "RDS INSTANCE CLASS"
    type        = string
    default     = "db.t3.micro"  # Add default
}

variable "allocated_storage" {
    description = "RDS STORAGE IN GB"
    type        = string
    default     = "20"  # Add default
}

variable "db_name" {
    type    = string
    default = "mydatabase"  # Add default
}

variable "db_username" {
    description = "USERNAME OF RDS"
    default     = "admin"
}

variable "db_password" {
    description = "PASSWORD OF RDS"
    sensitive   = true
    # No default - will prompt or use tfvars
}

# ALB VARIABLES
variable "target_grp_name" {
    description = "NAME OF TARGET GROUP"
    type        = string
    default     = "web-target-group"  # Add default
}

variable "alb_name" {
    type    = string
    default = "web-alb"  # Add default
}

