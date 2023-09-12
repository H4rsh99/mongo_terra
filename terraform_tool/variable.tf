variable "sg_name" {
  type    = string
  default = ""
}

variable "name_vpc" {
  type    = string
  default = ""
}

variable "inst_name1" {
  type    = string
  default = ""
}

variable "p_inst_name1" {
  type    = list(string)
}

variable "vpc_cidr_blocks" {
  type    = string
  default = ""
}   
variable "static1" {
  type = map(any)
  default = {
    ami      = "ami-01497eaa894d36592"
    publicip = true
    keyname  = "ninja"
    itype    = "t2.micro"
  }
}
variable "static2" {
  type = map(any)
  default = {
    ami      = "ami-0b0e51406ab26fe9a"
    publicip = false
    keyname  = "ninja"
    itype    = "t2.small"
  }
}
