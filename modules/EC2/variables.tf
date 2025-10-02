variable "instance_type" {
  type = string
  
}
variable "public_subnets" {
    type = list(string)
  
}
variable "ec2_sg_id" {
  
}
variable "ami_id" {
    description = "AMI ID OF EC2"
    type = string
  
}
variable "instance_count" {
  description = "number of instances"
  type = number
  default = 2
}
