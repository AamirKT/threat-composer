variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
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
}

variable "alb_load_balancer_arn" {
  description = "The ARN of the ALB to associate with the ECS service"
  type        = string
}

variable "family_name" {
  description = "The family name for the ECS task definition"
  type        = string
}

variable "network_mode" {
  description = "The network mode for the ECS task definition"
  type        = string
}

variable "requires_compatibilities" {
  description = "The launch type required by the ECS task definition"
  type        = list(string)
}

variable "cpu" {
  description = "The CPU units for the ECS task"
  type        = string
}

variable "memory" {
  description = "The memory for the ECS task"
  type        = string
}

variable "desired_count" {
  description = "The desired number of ECS tasks to run"
  type        = number
}

variable "deployment_maximum_percent" {
  description = "The maximum percentage of tasks that can be running during a deployment"
  type        = number
}

variable "deployment_minimum_healthy_percent" {
  description = "The minimum percentage of healthy tasks that must be running during a deployment"
  type        = number
}

variable "container_port" {
  description = "The port on which the container listens"
  type        = number
}

variable "ecs_service_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "container_name" {
  description = "The name of the container in the ECS task"
  type        = string
}

variable "launch_type" {
  description = "The launch type for the ECS service"
  type        = string
}

variable "aws_iam_role_name" {
  description = "The name of the IAM role for ECS task execution"
  type        = string
}

variable "policy_arn" {
  description = "The ARN of the IAM policy to attach to the ECS task execution role"
  type        = string
}
