variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
  default     = "threatcomposer-alb"
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate for HTTPS listener"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the ALB will be deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}
variable "alb_security_group_id" {
  description = "The security group ID to associate with the ALB"
  type        = string
  default     = null
}