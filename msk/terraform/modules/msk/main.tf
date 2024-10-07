provider "aws" {
  region = var.region
}

resource "aws_msk_cluster" "msk_cluster" {
  cluster_name           = var.cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.broker_count

  broker_node_group_info {
    instance_type   = var.instance_type
    client_subnets  = var.subnet_ids
    security_groups = [var.security_group_id]
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "TLS_PLAINTEXT"
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.msk_log_group.name
      }
    }
  }
}

resource "aws_cloudwatch_log_group" "msk_log_group" {
  name              = "/aws/msk/${var.cluster_name}"
  retention_in_days = 7
}
