terraform {
  required_version = ">1.7.5"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.27.0"
    }
  }

backend "s3" {
    bucket = "threatcomposer-aamir-s3"
    key    = "global/s3/terraform.tfstate"
    region = "eu-west-2"
    use_lockfile = true
    encrypt = true
  } 
}
provider "aws" {
  # Configuration options
  region = var.aws_region
}