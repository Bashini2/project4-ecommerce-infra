variable "vpc_id" {}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}


variable "frontend_sg_id" {}
variable "backend_sg_id" {}
variable "key_name" {}

