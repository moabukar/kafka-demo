output "msk_bootstrap_brokers" {
  description = "Bootstrap brokers for the MSK cluster"
  value       = aws_msk_cluster.msk_cluster.bootstrap_brokers_tls
}
