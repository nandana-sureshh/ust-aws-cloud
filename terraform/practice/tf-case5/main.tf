provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_servers" {

  for_each = instances

  ami           = each.value.ami
  instance_type = each.value.instance_type

  tags = {
    Name = each.key
  }
}