
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

