## Subnets da VPC A



resource "aws_subnet" "vpc-private-subnet-a" {
  count = length(var.private_subnets_a)
  vpc_id            = aws_vpc.infra_vpc_a.id
  cidr_block        = var.private_subnets_a[count.index]
  availability_zone = var.subnet_azs[count.index]

  tags              = {
    Name = format("banking-network-vpc-a-pv-%d", count.index)
    }

  depends_on = [aws_vpc.infra_vpc_a]
}

resource "aws_subnet" "vpc-public-subnet-a" {
  count = length(var.public_subnets_a)
  vpc_id            = aws_vpc.infra_vpc_a.id
  cidr_block        = var.public_subnets_a[count.index]             
  availability_zone = var.subnet_azs[count.index]                   
  map_public_ip_on_launch = true

  tags              = {
    Name = format("banking-network-vpc-a-pb-%d", count.index)
    }

  depends_on = [aws_vpc.infra_vpc_a]
}

resource "aws_subnet" "vpc-database-subnet-a" {
  count = length(var.database_subnets_a)
  vpc_id            = aws_vpc.infra_vpc_a.id
  cidr_block        = var.database_subnets_a[count.index]
  availability_zone = var.subnet_azs[count.index]                

  tags              = {
    Name = format("banking-network-vpc-a-db-%d", count.index)
    }

  depends_on = [aws_vpc.infra_vpc_a]
}
###############################################################################

## Subnets da VPC B

resource "aws_subnet" "vpc-private-subnet-b" {
  count = length(var.private_subnets_b)
  vpc_id            = aws_vpc.infra_vpc_b.id
  cidr_block        = var.private_subnets_b[count.index]
  availability_zone = var.subnet_azs[count.index]

  tags              = {
    Name = format("banking-network-vpc-b-pv-%d", count.index)
    }

  depends_on = [aws_vpc.infra_vpc_b]
}

resource "aws_subnet" "vpc-public-subnet-b" {
  count = length(var.public_subnets_b)
  vpc_id            = aws_vpc.infra_vpc_b.id
  cidr_block        = var.public_subnets_b[count.index]             
  availability_zone = var.subnet_azs[count.index]                   
  map_public_ip_on_launch = true

  tags              = {
    Name = format("banking-network-vpc-b-pb-%d", count.index)
    }

  depends_on = [aws_vpc.infra_vpc_b]
}

resource "aws_subnet" "vpc-database-subnet-b" {
  count = length(var.database_subnets_b)
  vpc_id            = aws_vpc.infra_vpc_b.id
  cidr_block        = var.database_subnets_b[count.index]             
  availability_zone = var.subnet_azs[count.index]                   

  tags              = {
    Name = format("banking-network-vpc-b-db-%d", count.index)
    }

  depends_on = [aws_vpc.infra_vpc_b]
}
###############################################################################

## Subnets da VPC C

resource "aws_subnet" "vpc-private-subnet-c" {
  count = length(var.private_subnets_c)
  vpc_id            = aws_vpc.infra_vpc_c.id
  cidr_block        = var.private_subnets_c[count.index]
  availability_zone = var.subnet_azs[count.index]

  tags              = {
    Name = format("banking-network-vpc-c-pv-%d", count.index)
    }

  depends_on = [aws_vpc.infra_vpc_c]
}

resource "aws_subnet" "vpc-public-subnet-c" {
  count = length(var.public_subnets_c)
  vpc_id            = aws_vpc.infra_vpc_c.id
  cidr_block        = var.public_subnets_c[count.index]             
  availability_zone = var.subnet_azs[count.index]                   
  map_public_ip_on_launch = true

  tags              = {
    Name = format("banking-network-vpc-c-pb-%d", count.index)
    }

  depends_on = [aws_vpc.infra_vpc_c]
}

resource "aws_subnet" "vpc-database-subnet-c" {
  count = length(var.database_subnets_c)
  vpc_id            = aws_vpc.infra_vpc_c.id
  cidr_block        = var.database_subnets_c[count.index]             
  availability_zone = var.subnet_azs[count.index]                   

  tags              = {
    Name = format("banking-network-vpc-c-db-%d", count.index)
    }

  depends_on = [aws_vpc.infra_vpc_c]
}

