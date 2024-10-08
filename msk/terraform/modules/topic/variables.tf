variable "topic_name" {
  description = "The name of the Kafka topic"
  type        = string
}

variable "partitions" {
  description = "The number of partitions for the Kafka topic"
  type        = number
  default     = 3
}

variable "replication_factor" {
  description = "The replication factor for the Kafka topic"
  type        = number
  default     = 3
}

variable "cleanup_policy" {
  description = "Cleanup policy for the topic (compact, delete)"
  type        = string
  default     = "delete"
}

variable "min_insync_replicas" {
  description = "Minimum number of replicas in sync for writes"
  type        = number
  default     = 2
}

variable "retention_ms" {
  description = "Retention time in milliseconds"
  type        = string
  default     = "604800000" # 7 days
}

variable "segment_bytes" {
  description = "The maximum size of a segment file in bytes"
  type        = string
  default     = "1073741824" # 1GB
}

variable "compression_type" {
  description = "The compression type (gzip, snappy, lz4, etc.)"
  type        = string
  default     = "gzip"
}
