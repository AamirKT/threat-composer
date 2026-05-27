variable "vpc_cidr" {
  description = "CIDR block for vpc"
  type        = string
}

variable "vpc_name" {
  description = "Name for the VPC and related resources"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "availability_mode" {
  description = "The availability mode for the NAT Gateway"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "public_subnet_names" {
  description = "Names for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "private_subnet_names" {
  description = "Names for private subnets"
  type        = list(string)
}

variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
  default     = "threatcomposer-alb"
}