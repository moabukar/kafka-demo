output "topic_name" {
  description = "The name of the Kafka topic"
  value       = kafka_topic.this.name
}

output "partitions" {
  description = "The number of partitions for the Kafka topic"
  value       = kafka_topic.this.partitions
}
