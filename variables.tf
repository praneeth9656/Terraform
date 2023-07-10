variable "cidr_block" {
    description = "CIDR blocks for VPCs"
    default = ["10.0.0.0/16","10.1.0.0/16"]

  
}
variable "subnet_cidr_block" {
    description = "CIDR blocks for VPCs"
    default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24","10.0.4.0/24"]

  
}



variable "access_key" {
  
}
variable "secret_key" {
  
}