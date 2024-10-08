provider "aws" {
  region = var.region
}

# dedicated VPC for MSK
resource "aws_vpc" "msk_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "msk-vpc"
  }
}

resource "aws_subnet" "msk_subnets" {
  count             = var.subnet_count
  vpc_id            = aws_vpc.msk_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.msk_vpc.cidr_block, 8, count.index) # Ensure appropriate CIDR calculation
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "msk-subnet-${count.index}"
  }
}

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

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

##

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.msk_vpc.id

  tags = {
    Name = "msk-internet-gateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.msk_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "msk-public-route-table"
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  count          = var.subnet_count
  subnet_id      = element(aws_subnet.msk_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}
