variable "ami_id" {
  description = "The AMI ID to use for instances"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use"
  type        = string
  default     = "t3.micro"
}

variable "ec2_sg_id" {
  description = "Security group ID for EC2 instances"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs where instances will be launched"
  type        = list(string)
}

variable "target_group_arns" {
  description = "List of target group ARNs for load balancer integration"
  type        = list(string)
  default     = []
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "web"
}

variable "desired_capacity" {
  description = "Desired number of instances"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of instances"
  type        = number
  default     = 5
}

variable "min_size" {
  description = "Minimum number of instances"
  type        = number
  default     = 1
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default     = null
}

variable "associate_public_ip" {
  description = "Whether to associate public IP addresses"
  type        = bool
  default     = false
}

variable "volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 20
}

variable "volume_type" {
  description = "Root volume type"
  type        = string
  default     = "gp3"
}

variable "user_data" {
  description = "User data script content (optional)"
  type        = string
  default     = null
}

variable "health_check_type" {
  description = "Health check type - EC2 or ELB"
  type        = string
  default     = "EC2"
}

variable "health_check_grace_period" {
  description = "Time in seconds after instance comes into service before checking health"
  type        = number
  default     = 300
}

variable "wait_for_capacity_timeout" {
  description = "How long to wait for instances to be healthy"
  type        = string
  default     = "10m"
}

variable "termination_policies" {
  description = "List of termination policies"
  type        = list(string)
  default     = ["Default"]
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "enable_scaling_policies" {
  description = "Whether to enable auto-scaling policies"
  type        = bool
  default     = false
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}