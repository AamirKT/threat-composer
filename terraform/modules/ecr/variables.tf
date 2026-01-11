variable "repository_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "The image tag mutability setting for the ECR repository"
  type        = string
  default     = "IMMUTABLE"
}

variable "scan_on_push" {
  description = "Whether to enable image scanning on push"
  type        = bool
  default     = true
}