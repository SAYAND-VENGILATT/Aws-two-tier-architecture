
variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
  
}
variable "public_subnets" {
  type= list(string)
}
variable "private_subnets" {
  type= list(string)
}
variable "availability_zones"{
  type = list(string)
  default = [ "us-east-1a", "us-east-1b" ]
}
  
