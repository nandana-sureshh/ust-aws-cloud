
provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "main-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "my_subnet_a" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidr_a
  availability_zone = var.availability_zone_a

  tags = {
    Name        = "subnet_a"
    Environment = var.environment
  }
}

resource "aws_subnet" "my_subnet_b" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidr_b
  availability_zone = var.availability_zone_b

  tags = {
    Name        = "subnet_b"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_security_group" "my_sg" {
name = "tf-sg-1"
description = "Security group for practice"
vpc_id = aws_vpc.my_vpc.id

tags = {
Name = "tf-sg-1"
Environment = var.environment
}
}

resource "aws_security_group_rule" "ssh_inbound" {
type = "ingress"
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = [var.allowed_ssh_cidr]
security_group_id = aws_security_group.my_sg.id
}

resource "aws_security_group_rule" "http_inbound" {
type = "ingress"
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = [var.allowed_http_cidr]
security_group_id = aws_security_group.my_sg.id
}

resource "aws_security_group_rule" "https_inbound" {
type = "ingress"
from_port = 443
to_port = 443
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
security_group_id = aws_security_group.my_sg.id
}

resource "aws_security_group_rule" "outbound_all" {
type = "egress"
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
security_group_id = aws_security_group.my_sg.id
}
