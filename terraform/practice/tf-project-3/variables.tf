variable "aws_region" {
    type =string
    default = "us-east-1"
}

variable "vpc_cidr" {
    type =string
    default = "10.0.0.0/16"
}

variable "environment" {
    type =string
    default = "dev"
}

variable "subnet_cidr_a" {
    type =string
    default = "10.0.1.0/24"
}

variable "availability_zone_a" {
    type =string
    default = "us-east-1a"
}

variable "subnet_cidr_b" {
    type =string
    default = "10.0.2.0/24"
}

variable "availability_zone_b" {
    type =string
    default = "us-east-1b"
}

variable "allowed_ssh_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "allowed_http_cidr" {
  type    = string
  default = "0.0.0.0/0"
}