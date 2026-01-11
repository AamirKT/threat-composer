variable "vpc_cidr" {
  description = "CIDR block for vpc"
  type = string
  default = "10.0.0.0/16"
  }

variable "vpc_name" {
  default = "threatcomposer-vpc"
}

variable "aws_region" {
  default = "eu-west-2"  
}

variable "availability_zones" {
  description = "List of availability zones"
  type = list(string)
  default = ["eu-west-2a", "eu-west-2b"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
  
variable "public_subnet_names" {
  description = "Names for public subnets"
  type = list(string)
  default = ["public-subnet-1", "public-subnet-2"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "private_subnet_names" {
  description = "Names for private subnets"
  type = list(string)
  default = ["private-subnet-1", "private-subnet-2"]
}