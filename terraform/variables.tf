variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "route53_zone_id" {
  description = "The Route 53 Hosted Zone ID where the domain is managed"
  type        = string
}

variable "container_image" {
  description = "The container image to use for the ECS task"
  type        = string
}

variable "domain_name" {
  description = "The domain name for which to request the ACM certificate"
  type        = string
}