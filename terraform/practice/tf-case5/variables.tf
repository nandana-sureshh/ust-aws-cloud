variable "instances" {

  type = map(object({
    instance_type = string
    ami           = string
  }))

  default = {

    web = {
      instance_type = "t2.micro"
      ami           = "ami-0c02fb55956c7d316"
    }

    app = {
      instance_type = "t2.small"
      ami           = "ami-0c02fb55956c7d316"
    }

    db = {
      instance_type = "t2.medium"
      ami           = "ami-0c02fb55956c7d316"
    }
  }
}