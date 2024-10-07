variable "region" {
  description = "The AWS region to deploy MSK"
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "VPC CIDR block for MSK cluster"
  default     = "10.0.0.0/16"
}
