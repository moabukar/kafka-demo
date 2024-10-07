variable "region" {
  description = "The AWS region to deploy MSK"
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "Name of the MSK cluster"
  default     = "my-msk-cluster"
}

variable "kafka_version" {
  description = "The version of Kafka to use in MSK"
  default     = "2.8.1"
}

variable "broker_count" {
  description = "The number of MSK brokers"
  default     = 3
}

variable "instance_type" {
  description = "The Kafka instance type"
  default     = "kafka.m5.large"
}

variable "subnet_ids" {
  description = "Subnets where MSK brokers will run"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group for MSK brokers"
  type        = string
}
