resource "aws_instance" "kafka_client" {
  ami                = "ami-0abcdef1234567890" # Replace with a valid Amazon Linux 2 AMI ID in your region
  instance_type      = "t2.micro"
  subnet_id          = element(module.network.subnet_ids, 0)
  security_group_ids = [module.network.security_group_id]

  key_name = "coderco-key" # Replace with your actual key pair

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y java-1.8.0-openjdk-devel
    wget https://archive.apache.org/dist/kafka/2.8.1/kafka_2.13-2.8.1.tgz
    tar -xzf kafka_2.13-2.8.1.tgz
    cd kafka_2.13-2.8.1
    echo 'export KAFKA_HOME=$(pwd)' >> ~/.bashrc
    source ~/.bashrc
  EOF

  tags = {
    Name = "Kafka-Client-Instance"
  }
}
