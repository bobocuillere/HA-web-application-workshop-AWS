provider "aws" {
  profile = var.AWS_PROFILE
  region  = var.AWS_REGION
}

# VPC of the project
resource "aws_vpc" "Wordpress-workshop" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name                = "Wordpress-workshop"
    main_route_table_id = "Test"
  }
}

# Public subnets A and B
resource "aws_subnet" "Public-Subnets" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.Wordpress-workshop.id
  cidr_block        = cidrsubnet(var.subnets_cidr, 4, count.index)
  availability_zone = element(var.azs, count.index)


  tags = {
    count = length(var.AB)
    Name  = "Public-Subnet-${element(var.AB, count.index)}"
  }
}

# Application subnets A and B
resource "aws_subnet" "Application-Subnets" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.Wordpress-workshop.id
  cidr_block        = cidrsubnet(var.subnets_cidr, 4, count.index + 2)
  availability_zone = element(var.azs, count.index)


  tags = {
    count = length(var.AB)
    Name  = "Application-Subnet-${element(var.AB, count.index)}"
  }
}

# Data subnets A and B
resource "aws_subnet" "Data-Subnets" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.Wordpress-workshop.id
  cidr_block        = cidrsubnet(var.subnets_cidr, 4, count.index + 4)
  availability_zone = element(var.azs, count.index)


  tags = {
    count = length(var.AB)
    Name  = "Data-Subnet-${element(var.AB, count.index)}"
  }
}
# Internet Gateway
resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.Wordpress-workshop.id

  tags = {
    Name = "WP Internet Gateway"
  }
}
# IGW's routes
resource "aws_route_table" "igw-route" {


  vpc_id = aws_vpc.Wordpress-workshop.id

  route {
    cidr_block = var.igw_routes[0]
    gateway_id = aws_internet_gateway.igw.id

  }
  tags = {
    "Name" = "Wordpress Public"
  }
}
#IGW's subnets association
resource "aws_route_table_association" "igw-subnets-association" {

  count          = 2
  subnet_id      = aws_subnet.Public-Subnets[count.index].id
  route_table_id = aws_route_table.igw-route.id
}
#NAT's gateway elastic addresses for the Application subnets
resource "aws_eip" "eip-natA" {


  vpc = true
  tags = {
    "Name" = "EIP-NAT-A"
  }
}


resource "aws_eip" "eip-natB" {

  vpc = true

  tags = {
    "Name" = "EIP-NAT-B"
  }
}

#Nat Gateways for both the Public Subnets
resource "aws_nat_gateway" "natA" {

  allocation_id = aws_eip.eip-natA.id
  subnet_id     = aws_subnet.Public-Subnets[0].id

  tags = {
    "Name" = "NAT Public Subnet A"
  }
}

resource "aws_nat_gateway" "natB" {

  allocation_id = aws_eip.eip-natB.id
  subnet_id     = aws_subnet.Public-Subnets[1].id

  tags = {
    "Name" = "NAT Public Subnet B"
  }
}

# Route table for the NatGateways
resource "aws_route_table" "nat-route" {

  count = length(var.azs)

  vpc_id = aws_vpc.Wordpress-workshop.id

  route {

    cidr_block     = var.nat_routes[0]
    nat_gateway_id = aws_nat_gateway.natA.id

  }


  tags = {

    "Name" = "Application ${element(var.AB, count.index)} subnet"
  }
}

resource "aws_route" "nat-route-B" {
  count                  = 0
  route_table_id         = aws_route_table.nat-route[count.index + 1].id
  destination_cidr_block = var.nat_routes[0]
  nat_gateway_id         = aws_nat_gateway.natB.id
}
resource "aws_route_table_association" "nat-subnets-association" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.Application-Subnets[count.index].id
  route_table_id = aws_route_table.nat-route[count.index].id
}

