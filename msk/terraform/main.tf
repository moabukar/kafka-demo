provider "aws" {
  region = var.region
}

# Call the network module
module "network" {
  source       = "../network" # Path to the network module
  region       = var.region
  vpc_cidr     = var.vpc_cidr
  subnet_count = var.subnet_count
}

# Call the MSK module
module "msk" {
  source            = "../msk" # Path to the MSK module
  region            = var.region
  cluster_name      = var.cluster_name
  kafka_version     = var.kafka_version
  broker_count      = var.broker_count
  instance_type     = var.instance_type
  subnet_ids        = module.network.subnet_ids
  security_group_id = module.network.security_group_id
}
