variable "cidr_block" {
    description = "CIDR blocks for VPCs"
    default = ["10.0.0.0/16","10.1.0.0/16"]

  
}
variable "subnet_cidr_block" {
    description = "CIDR blocks for VPCs"
    default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24","10.0.4.0/24"]

  
}
# variable "subnet_cidr_block_VPC2" {
#     description = "CIDR blocks for VPCs"
#     default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24","10.0.4.0/24"]

  
# }

variable "amis" {
    description = "Image_ids"
    default = {
        us-east-1= "ami-06ca3ca175f37dd66"
        us-east-2= "ami-069d73f3235b535bd"
    }
  
}
variable "env" {
    description = "Environment"
    default = "PROD"
  
}



variable "access_key" {
  
}
variable "secret_key" {
  
}