provider "aws" {
    region = var.region
}

resource "aws_instance" "my_instance" {
    ami = var.ami[var.region]
    instance_type = "t2.micro"

    tags = {
        Name = "ami-instance"
    }
}