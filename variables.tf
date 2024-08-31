variable "projectname" {
    type = string
  
}

variable "cidr_block"{
    type = string
    default = "10.0.0.0/16"
}

variable "common_tags" {
    type = map
    default ={}
  
}
variable "environment"{
    type = string
}

variable "vpc_tags" {
    type = map
    default ={}
  
}
variable "public_subnet_tags" {
    type = map
    default ={}
  
}

variable "public_subnet_cidr" {
    type= list
    validation {
      condition = length(var.public_subnet_cidr) <4 #less than 3 CIDRs allowed. you can modify this number according to your use 
      error_message = "Please give 2 only"
    }
  
}
variable "private_subnet_cidr" {
    type= list
    validation {
      condition = length(var.private_subnet_cidr) <4#less than 3 CIDRs allowed. you can modify this number according to your use
      error_message = "Please give 2 only"
    }
  
}
variable "database_subnet_cidr" {
    type= list
    validation {
      condition = length(var.database_subnet_cidr) <4#less than 3 CIDRs allowed. you can modify this number according to your use
      error_message = "Please give 2 only"
    }
  
}

variable "private_subnet_tags" {
    type = map
    default ={}
  
}

variable "database_subnet_tags" {
    type = map
    default ={}
  
}

variable "internet_gateway_tags" {
    type = map
    default = {}
  
}

variable "public_route_table_tags" {
    type = map
    default = {}
  
}

variable "private_route_table_tags" {
    type = map
    default = {}
  
}

variable "database_route_table_tags" {
    type = map
    default = {}
  
}