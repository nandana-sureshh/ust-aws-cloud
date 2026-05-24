output "mysql_configuration" {

  value = {
    instance_type = var.mysql_config[0]
    multi_az      = var.mysql_config[1]
    storage_size  = var.mysql_config[2]
  }
}