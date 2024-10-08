provider "kafka" {
  bootstrap_servers = [
    "b-1.mymskcluster.0ss0yn.c3.kafka.eu-west-2.amazonaws.com:9092",
    "b-2.mymskcluster.0ss0yn.c3.kafka.eu-west-2.amazonaws.com:9092",
    "b-3.mymskcluster.0ss0yn.c3.kafka.eu-west-2.amazonaws.com:9092"
  ]

  # Optional authentication and TLS setup
  # ca_cert         = var.ca_cert_file
  # client_cert     = var.client_cert_file
  # client_key      = var.client_key_file
  # skip_tls_verify = false
  # tls_enabled = true  # If using TLS
  # sasl_username = var.kafka_user  # If using SASL authentication
  # sasl_password = var.kafka_password
}


resource "kafka_topic" "this" {
  name               = var.topic_name
  replication_factor = var.replication_factor
  partitions         = var.partitions

  config = {
    "cleanup.policy"      = var.cleanup_policy
    "min.insync.replicas" = var.min_insync_replicas
    "retention.ms"        = var.retention_ms
    "segment.bytes"       = var.segment_bytes
    "compression.type"    = var.compression_type
  }
}
