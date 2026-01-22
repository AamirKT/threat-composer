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

variable "family_name" {
  description = "The family name for the ECS task definition"
  type        = string
  default     = "threatcomposer-ecs-task"
}

variable "network_mode" {
  description = "The network mode for the ECS task definition"
  type        = string
  default     = "awsvpc"
}

variable "requires_compatibilities" {
  description = "The launch type required by the ECS task definition"
  type        = list(string)
  default     = ["FARGATE"]
}

variable "cpu" {
  description = "The CPU units for the ECS task"
  type        = string
  default     = "512"
}

variable "memory" {
  description = "The memory for the ECS task"
  type        = string
  default     = "1024"
}

variable "desired_count" {
  description = "The desired number of ECS tasks to run"
  type        = number
  default     = 2
}

variable "container_port" {
  description = "The port on which the container listens"
  type        = number
  default     = 3000
}

variable "ecs_service_name" {
  description = "The name of the ECS service"
  type        = string
  default     = "threatcomposer-ecs-service"
}

variable "container_name" {
  description = "The name of the container in the ECS task"
  type        = string
  default     = "threatcomposer-container"
}

variable "launch_type" {
  description = "The launch type for the ECS service"
  type        = string
  default     = "FARGATE"
}

variable "aws_iam_role_name" {
  description = "The name of the IAM role for ECS task execution"
  type        = string
  default     = "threatcomposer-ecs-task-execution-role"
}

variable "policy_arn" {
  description = "The ARN of the IAM policy to attach to the ECS task execution role"
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}