terraform {
    required_providers {
        aws = {
            source = "registry.terraform.io/hashicorp/aws"
            version = "6.44.0"
        }
    }
}

provider "aws" {
    region = var.aws_region
}

resource "aws_instance" "ec2_with_runtime" {
    instance_type = var.instance_type
    ami = var.ami_id

    tags = {
        Name = var.instance_name
    }

}