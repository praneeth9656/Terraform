provider "aws" {
    access_key = var.access_key
    secret_key = var.secret_key
    region = "us-east-1"
  
}

resource "aws_vpc" "VPC" {
    count = length(var.cidr_block)
    
    cidr_block = var.cidr_block[count.index]

    tags = {
        Name = "VPC${count.index+1}"
    }
    
  
}

resource "aws_subnet" "VPC1_subnets" {
    count = length(var.subnet_cidr_block)
    
    vpc_id     = aws_vpc.VPC[0].id
  cidr_block = var.subnet_cidr_block[count.index]

  tags = {
    Name = "Subnet${count.index+1}"
  }
  
}