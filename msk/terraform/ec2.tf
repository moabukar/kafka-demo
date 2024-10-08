data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-hvm-*-x86_64-gp2"]
  }
}


## EC2 instance with kafka version 2.8.1
resource "aws_instance" "kafka_client" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = element(module.network.subnet_ids, 0)
  vpc_security_group_ids = [module.network.security_group_id]

  key_name = "mo-demo"

  associate_public_ip_address = true

  # Update the user_data to install Kafka 2.8.1
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y java-1.8.0-openjdk-devel

    # Download and extract Kafka 2.8.1
    wget https://archive.apache.org/dist/kafka/2.8.1/kafka_2.13-2.8.1.tgz
    tar -xzf kafka_2.13-2.8.1.tgz
    cd kafka_2.13-2.8.1

    # Set environment variables for Kafka
    echo 'export KAFKA_HOME=$(pwd)' >> ~/.bashrc
    echo 'export PATH=$PATH:$KAFKA_HOME/bin' >> ~/.bashrc
    source ~/.bashrc
  EOF

  tags = {
    Name = "Kafka-Client-Instance"
  }
}

output "kafka_client_public_ip" {
  value = "ssh -i mo-demo.pem ec2-user@${aws_instance.kafka_client.public_ip}"
}

## EC2 instance with kafka version 3.2.0 (use with msk cluster version 3.2.0)

# EC2 instance to act as Kafka client
# resource "aws_instance" "kafka_client" {
#   ami                    = data.aws_ami.amazon_linux.id
#   instance_type          = "t2.micro"
#   subnet_id              = element(module.network.subnet_ids, 0)
#   vpc_security_group_ids = [module.network.security_group_id]

#   key_name = "mo-dev"

#   # Update the user_data to install Kafka 3.2.0
#   user_data = <<-EOF
#     #!/bin/bash
#     sudo yum update -y
#     sudo yum install -y java-1.8.0-openjdk-devel

#     # Download and extract Kafka 3.2.0
#     wget https://archive.apache.org/dist/kafka/3.2.0/kafka_2.13-3.2.0.tgz
#     tar -xzf kafka_2.13-3.2.0.tgz
#     cd kafka_2.13-3.2.0

#     # Set environment variables for Kafka
#     echo 'export KAFKA_HOME=$(pwd)' >> ~/.bashrc
#     echo 'export PATH=$PATH:$KAFKA_HOME/bin' >> ~/.bashrc
#     source ~/.bashrc
#   EOF

#   tags = {
#     Name = "Kafka-Client-Instance"
#   }
# }
