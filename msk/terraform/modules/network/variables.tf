variable "region" {
  description = "The AWS region to deploy MSK"
  default     = "eu-west-2"
}

variable "vpc_cidr" {
  description = "VPC CIDR block for MSK cluster"
  default     = "10.0.0.0/16"
}

variable "subnet_count" {
  description = "Number of subnets to create"
  default     = 3
}
