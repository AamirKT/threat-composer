variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "threatcomposer-ecs-cluster"
}

variable "container_image" {
  description = "The container image to use for the ECS task"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the ECS tasks"
  type        = list(string)
}

variable "alb_tg_arn" {
  description = "The ARN of the ALB target group to associate with the ECS service"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the ECS cluster will be deployed"
  type        = string
}

variable "ecs_security_group_id" {
  description = "The security group ID to associate with the ECS tasks"
  type        = string
  default     = null
}

variable "alb_load_balancer_arn" {
  description = "The ARN of the ALB to associate with the ECS service"
  type        = string
}

