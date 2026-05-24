output "instance_names" {

  value = [
    for instance in aws_instance.my_servers :
    instance.tags.Name
  ]
}