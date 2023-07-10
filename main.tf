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

resource "aws_internet_gateway" "internet_gateway" {
  count = length(aws_vpc.VPC)
  vpc_id = aws_vpc.VPC[count.index].id
  tags = {
    Name = "Internet_Gateway_for_VPC${count.index+1}"
  }
  
}

resource "aws_route_table" "route_table" {
  count =length(aws_vpc.VPC)
  vpc_id = aws_vpc.VPC[count.index].id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway[count.index].id
  }
  tags = {
    Name = "VPC${count.index+1}routetable"
  }

  
}

resource "aws_route_table_association" "routetable_association" {
  count = length(aws_subnet.VPC1_subnets)
  subnet_id = aws_subnet.VPC1_subnets[count.index].id
  route_table_id = aws_route_table.route_table[0].id
  
}