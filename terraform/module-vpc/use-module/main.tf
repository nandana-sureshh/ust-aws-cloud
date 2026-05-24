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

module "my_vpc" {

  source = "nandana-sureshh/demoo/practice"
  version = "1.0.0"

  vpc_name           = "demo-vpc"
  vpc_cidr           = "10.0.0.0/16"
  az                 = "us-east-1a"
  environment        = "dev"
}