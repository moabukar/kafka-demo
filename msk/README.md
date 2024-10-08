# Kafka on MSK

Amazon Managed Streaming for Apache Kafka (MSK) is a service provided by AWS designed to minimise the amount of setup and management typically required to run an Apache Kafka cluster. You can read more [here](https://aws.amazon.com/msk/getting-started/)

## Setup

```bash
terraform init
terraform plan
terraform apply
```

## Bootstrap

```bash
ssh -i "mo-dev.pem" ec2-user@your-ec2-public-ip

source ~/.bashrc

cd kafka_2.13-2.8.1

$KAFKA_HOME/bin/kafka-topics.sh --create \
  --bootstrap-server <MSK_BOOTSTRAP_BROKER> \
  --replication-factor 3 \
  --partitions 3 \
  --topic test-topic


# Replace <MSK_BOOTSTRAP_BROKER> with one of the bootstrap brokers from the Terraform output, for example:
# b-1.cluster-1.abcdef1234567890.eu-west-2.amazonaws.com:9092
bin/kafka-console-producer.sh --broker-list <MSK_BOOTSTRAP_BROKER> --topic test-topic

bin/kafka-console-producer.sh --broker-list b-2.my-msk-cluster.abcdef.c2.kafka.us-west-2.amazonaws.com:9092 --topic test-topic

kafka-console-producer.sh --broker-list b-1.mymskcluster.0ss0yn.c3.kafka.eu-west-2.amazonaws.com:9092 --topic my-new-topic

## Test by producing messages to the topic

## Test by consuming messages from the topic
bin/kafka-console-consumer.sh --bootstrap-server <MSK_BOOTSTRAP_BROKER> --topic test-topic --from-beginning


```

## Cleanup

```bash
terraform destroy
```
