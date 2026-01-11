variable domain_name {
  description = "The domain name for which to request the ACM certificate"
  type        = string
}   

variable "zone_id" {
  description = "The Route 53 Hosted Zone ID for domain validation"
  type        = string
}

variable "alb_zone_id" {
  description = "The Route 53 Hosted Zone ID for the Application Load Balancer"
  type        = string
}

variable "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  type        = string
}
