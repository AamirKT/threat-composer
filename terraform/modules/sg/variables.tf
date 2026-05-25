variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created"
  type        = string
}

variable "alb_name" {
  description = "The name of the Application Load Balancer associated with this security group"
  type        = string
}

variable "container_port" {
  description = "The port on which the ECS container will listen (e.g., 3000)"
  type        = number
}