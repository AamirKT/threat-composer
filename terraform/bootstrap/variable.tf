variable "s3_bucket_name" {
  description = "The name of the S3 bucket to create for storing Terraform state"
  type        = string
  default     = "threatcomposer-aamir-s3"
}

variable "repository_name" {
  description = "The name of the ECR repository to create"
  type        = string
  default     = "threat-composer-repository"
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the ECR repository (MUTABLE or IMMUTABLE)"
  type        = string
  default     = "IMMUTABLE"
}
