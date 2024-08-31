locals {
  name ="${var.projectname}_${var.environment}"
  az_names = slice(data.aws_availability_zones.azs.names,0,2)
}

data "aws_availability_zones" "azs" {
  state = "available"
}