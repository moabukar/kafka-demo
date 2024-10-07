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
ssh -i "your-key.pem" ec2-user@your-ec2-public-ip

$KAFKA_HOME/bin/kafka-console-producer.sh --bootstrap-server ${MSK_BOOTSTRAP_BROKER} --topic my-topic

$KAFKA_HOME/bin/kafka-console-consumer.sh --bootstrap-server ${MSK_BOOTSTRAP_BROKER} --topic my-topic --from-beginning

```
