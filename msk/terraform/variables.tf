variable "region" {
  description = "The AWS region"
  default     = "eu-west-2"
}

variable "vpc_cidr" {
  description = "The VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "subnet_count" {
  description = "Number of subnets to create"
  default     = 3
}

variable "cluster_name" {
  description = "Name of the MSK cluster"
  default     = "msk-demo"
}

variable "kafka_version" {
  description = "Kafka version for MSK"
  default     = "2.8.1"
}

variable "broker_count" {
  description = "Number of Kafka brokers"
  default     = 3
}

variable "instance_type" {
  description = "Kafka broker instance type"
  default     = "kafka.m5.large"
}
