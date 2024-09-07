# This file has terraform configuration to create following resources
# VPC
# SUBNETS
# INTERNET GATEWAY


resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = merge(var.common_tags,var.vpc_tags,{
    Name = "${local.name}"
  })
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = local.az_names[count.index % length(local.az_names)]

  tags = merge(var.common_tags,var.public_subnet_tags,{
    Name = "${local.name}-public-${local.az_names[count.index % length(local.az_names)]}"
  })
  }

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone = local.az_names[count.index % length(local.az_names)]

  tags = merge(var.common_tags,var.public_subnet_tags,{
    Name = "${local.name}-private-${local.az_names[count.index % length(local.az_names) ]}"
  })
  }

  resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidr[count.index]
  availability_zone = local.az_names[count.index % length(local.az_names)]

  tags = merge(var.common_tags,var.database_subnet_tags,{
    Name = "${local.name}-database-${local.az_names[count.index % length(local.az_names) ]}"
  })
  }


resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.common_tags,var.internet_gateway_tags,{
    Name = "${local.name}-internet_gw"
  })
}

resource "aws_eip" "eip" {
  domain           = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet_gw]
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.public_route_table_tags,
    {
        Name = "${local.name}-public"
    }
  )

}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.public_route_table_tags,
    {
        Name = "${local.name}-private"
    }
  )

}

resource "aws_route_table" "database" {
    vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.public_route_table_tags,
    {
        Name = "${local.name}-database"
    }
  )

}

resource "aws_route" "public_subnet_routes" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.internet_gw.id
}

resource "aws_route" "private_subnet_routes" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gw.id
}

resource "aws_route" "database_subnet_routes" {
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gw.id
}

resource "aws_route_table_association" "public_subnet_association" {
  count = length(var.public_subnet_cidr)
  subnet_id = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_subnet_association" {
  count = length(var.private_subnet_cidr)
  subnet_id = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "database_subnet_association" {
  count = length(var.database_subnet_cidr)
  subnet_id = element(aws_subnet.database[*].id, count.index)
  route_table_id = aws_route_table.database.id
  
}