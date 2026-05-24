output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.my_vpc.cidr_block
}

output "subnet_id_a" {
  value = aws_subnet.my_subnet_a.id
}

output "subnet_cidr_a" {
  value = aws_subnet.my_subnet_a.cidr_block
}

output "subnet_id_b" {
  value = aws_subnet.my_subnet_b.id
}

output "subnet_cidr_b" {
  value = aws_subnet.my_subnet_b.cidr_block
}

output "internet_gateway_id" {
  value = aws_internet_gateway.my_igw.id
}

