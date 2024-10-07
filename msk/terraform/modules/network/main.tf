provider "aws" {
  region = var.region
}

# Create a VPC for MSK
resource "aws_vpc" "msk_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "msk-vpc"
  }
}

# Create subnets in different availability zones
resource "aws_subnet" "msk_subnets" {
  count             = 3
  vpc_id            = aws_vpc.msk_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.msk_vpc.cidr_block, 4, count)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "msk-subnet-${count.index}"
  }
}

# Security group for MSK cluster
resource "aws_security_group" "msk_sg" {
  vpc_id = aws_vpc.msk_vpc.id
  tags = {
    Name = "msk-sg"
  }

  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.msk_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_availability_zones" "available" {}
