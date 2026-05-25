variable "vpc_name" {
  description = "The name of the VPC, used for naming resources"
  type        = string
  default     = "threatcomposer"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/24"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.0.0/26", "10.0.0.64/26"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.0.128/26", "10.0.0.192/26"]
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]
}

variable "public_subnet_names" {
  description = "Names for public subnets"
  type        = list(string)
  default     = ["public-subnet-1", "public-subnet-2"]
}

variable "private_subnet_names" {
  description = "Names for private subnets"
  type        = list(string)
  default     = ["private-subnet-1", "private-subnet-2"]
}

variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "route53_zone_id" {
  description = "The Route 53 Hosted Zone ID where the domain is managed"
  type        = string
}

variable "container_name" {
  description = "The name of the container in the ECS task"
  type        = string
  default     = "threatcomposer-container"
}

variable "container_image" {
  description = "The container image to use for the ECS task"
  type        = string
  default     = "657672948849.dkr.ecr.eu-west-2.amazonaws.com/threat-composer-repository:git-8c9d1c18"
}

variable "container_port" {
  description = "The port on which the ECS container will listen (e.g., 3000)"
  type        = number
  default     = 3000
}

variable "domain_name" {
  description = "The domain name for which to request the ACM certificate"
  type        = string
}

variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
  default     = "threatcomposer-alb"
}

variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "threatcomposer-cluster"
}

variable "ecs_service_name" {
  description = "The name of the ECS service"
  type        = string
  default     = "threatcomposer-ecs-service"
}

variable "family_name" {
  description = "The family name for the ECS task definition"
  type        = string
  default     = "threatcomposer-task"
}

variable "cpu" {
  description = "The CPU units for the ECS task"
  type        = string
  default     = "512"
}

variable "memory" {
  description = "The memory for the ECS task (e.g., 1024 for 1GB)"
  type        = string
  default     = "1024"
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

variable "desired_count" {
  description = "The desired number of ECS tasks to run"
  type        = number
  default     = 2
}

variable "deployment_maximum_percent" {
  description = "The maximum percentage of tasks that can be running during a deployment"
  type        = number
  default     = 200
}

variable "deployment_minimum_healthy_percent" {
  description = "The minimum percentage of healthy tasks that must be running during a deployment"
  type        = number
  default     = 50
}

variable "launch_type" {
  description = "The launch type for the ECS service (e.g., FARGATE)"
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
