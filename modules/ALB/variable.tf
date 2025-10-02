variable "alb_name" {
  description = "APPLICATION LOADBALANCER NAME"
  type=string
}
variable "public_subnets" {
  type = list(string)
}
variable "target_grp_name" {
    description = "NAME OF TARGET GROUP"
    type = string
}
variable "vpc_id" {
  
}
variable "alb_sg_id" {
  type = string 
}