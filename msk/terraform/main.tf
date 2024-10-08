provider "aws" {
  region = var.region
}

module "network" {
  source       = "./modules/network"
  region       = var.region
  vpc_cidr     = var.vpc_cidr
  subnet_count = var.subnet_count
}

module "msk" {
  source            = "./modules/msk"
  region            = var.region
  cluster_name      = var.cluster_name
  kafka_version     = var.kafka_version
  broker_count      = var.broker_count
  instance_type     = var.instance_type
  subnet_ids        = module.network.subnet_ids
  security_group_id = module.network.security_group_id
}

output "kafka_zookeeper_connect_string" {
  value = module.msk.zookeeper_connect_string
}

output "msk_bootstrap_brokers" {
  description = "Bootstrap brokers for the MSK cluster"
  value       = module.msk.msk_bootstrap_brokers
}
