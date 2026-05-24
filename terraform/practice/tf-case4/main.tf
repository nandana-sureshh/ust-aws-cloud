provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "mysql_db" {

  allocated_storage = var.mysql_config[2]

  engine         = "mysql"
  engine_version = "8.0"

  instance_class = var.mysql_config[0]

  username = "admin"
  password = "Password123!"

  db_name = "mydb"

  multi_az = var.mysql_config[1]

  publicly_accessible = false

  skip_final_snapshot = true

  tags = {
    Name = "Terraform-MySQL-DB"
  }
}