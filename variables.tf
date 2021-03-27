variable "aws_region" {
  description = "Region for the VPC"
  default = "ap-southeast-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default = "10.0.254.0/24"
}

variable "private_web_cidr" {
  description = "CIDR for web services"
  default = "10.0.0.0/24"
}

variable "private_middleware_cidr" {
  description = "CIDR for middleware"
  default = "10.0.1.0/24"
}

variable "private_db_cidr" {
  description = "CIDR for databases"
  default = "10.0.2.0/24"
}


