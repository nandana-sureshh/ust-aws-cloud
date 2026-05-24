provider "aws" {
    region = "us-east-1"
}
resource "aws_instance" "instance_wit_defaults" {
    ami = ""
    instance_type = ""

    tags = {
        Name = ""
    }
    
    }