data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-hvm-*-x86_64-gp2"]
  }
}

# EC2 instance to act as Kafka client
resource "aws_instance" "kafka_client" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = element(module.network.subnet_ids, 0)
  vpc_security_group_ids = [module.network.security_group_id]

  key_name = "your-key-pair" # Replace with your actual key pair

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
