terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}

module "my_ec2" {
   # source = "git::https://github.com/nandana-sureshh/terraform-practice.git"
   source = "nandana-sureshh/demo/practice"
   version = "1.0.1"
    ami_id = "ami-091138d0f0d41ff90"
    instance_type = "t2.micro"
    instance_name = "git-demo"
}