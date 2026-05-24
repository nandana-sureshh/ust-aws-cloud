variable "region" {
    type = string
    default = "us-east-1"
}

variable "ami" {
    type = map(string)

    default = {
        us-east-1 = "ami-0236922087fa98b6e"
        us-east-2 = "ami-008fe2fc65df48dac"
    }
}