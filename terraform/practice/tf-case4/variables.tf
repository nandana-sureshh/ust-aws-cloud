variable "mysql_config" {

  description = "MySQL database configuration"

  type = tuple([
    string,
    bool,
    number
  ])

  default = [
    "db.t3.micro",
    false,
    20
  ]
}