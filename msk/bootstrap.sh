#!/bin/bash
# Install necessary packages
sudo yum update -y
sudo yum install -y java-1.8.0-openjdk

# Download Kafka binaries
wget https://archive.apache.org/dist/kafka/2.8.1/kafka_2.13-2.8.1.tgz
tar -xvzf kafka_2.13-2.8.1.tgz
cd kafka_2.13-2.8.1

# Setup Kafka producer/consumer
echo 'export KAFKA_HOME=$(pwd)' >> ~/.bashrc
source ~/.bashrc

# Create topics (run this inside EC2)
$KAFKA_HOME/bin/kafka-topics.sh --create --topic my-topic --bootstrap-server ${MSK_BOOTSTRAP_BROKER} --partitions 3 --replication-factor 3
