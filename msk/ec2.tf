resource "aws_instance" "kafka_client" {
  ami             = "ami-0abcdef1234567890" # Use the appropriate Amazon Linux 2 AMI
  instance_type   = "t2.micro"
  subnet_id       = element(aws_subnet.msk_subnets[*].id, 0)
  security_groups = [aws_security_group.msk_sg.id]

  user_data = <<-EOF
    ${file("bootstrap.sh")}  # Load the bootstrap script
  EOF

  tags = {
    Name = "kafka-client"
  }
}
