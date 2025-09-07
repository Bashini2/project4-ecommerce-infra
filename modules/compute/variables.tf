variable "project" {}
variable "public_subnet_id" {}
variable "private_subnet_id" {}
variable "frontend_sg_id" {}
variable "backend_sg_id" {}
variable "key_name" { 
  description = "The name of the existing AWS key pair to use for EC2"
  type        = string
}

