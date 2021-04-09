#Route Tables e Associations da VPC A

resource "aws_route_table" "public_table_a" {
  vpc_id = aws_vpc.infra_vpc_a.id
  
  depends_on = [
    aws_vpc.infra_vpc_a
    ]
  
  tags = {
    Name = format("%s-vpc-a-pb-table", var.infra_name)
    }
}

resource "aws_route_table" "private_table_a" {
  vpc_id = aws_vpc.infra_vpc_a.id

  depends_on = [
    aws_vpc.infra_vpc_a
  ]

    tags = {
    Name = format("%s-vpc-a-pv-table", var.infra_name)
    }
}

resource "aws_route" "public_internet_gateway_a" {
  route_table_id         = aws_route_table.public_table_a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_a.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "tgw_a_to_b" {
  route_table_id         = aws_route_table.public_table_a.id
  destination_cidr_block = var.cidr_block_b # 10.0.0.0/8?
  transit_gateway_id = module.tgw.tgw_id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "tgw_a_to_c" {
  route_table_id         = aws_route_table.public_table_a.id
  destination_cidr_block = var.cidr_block_c
  transit_gateway_id = module.tgw.tgw_id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "private_internet_gateway_a" {
  route_table_id         = aws_route_table.private_table_a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id             = aws_nat_gateway.nat_a.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "public_a"{  
   count = 4
   subnet_id = aws_subnet.vpc-public-subnet-a[count.index].id
   route_table_id = aws_route_table.public_table_a.id

   depends_on = [
     aws_subnet.vpc-public-subnet-a,
     aws_vpc.infra_vpc_a
   ]
}

resource "aws_route_table_association" "private_a"{  
   count = 4
   subnet_id = aws_subnet.vpc-private-subnet-a[count.index].id
   route_table_id = aws_route_table.private_table_a.id

   depends_on = [
     aws_subnet.vpc-private-subnet-a,
     aws_vpc.infra_vpc_a
   ]
}
######################################################################################

#Route Tables e Associations da VPC B

resource "aws_route_table" "public_table_b" {
  vpc_id = aws_vpc.infra_vpc_b.id
  
  depends_on = [
    aws_vpc.infra_vpc_b
    ]
  
  tags = {
    Name = format("%s-vpc-b-pb-table", var.infra_name)
    }
}

resource "aws_route_table" "private_table_b" {
  vpc_id = aws_vpc.infra_vpc_b.id

  depends_on = [
    aws_vpc.infra_vpc_b
  ]

    tags = {
    Name = format("%s-vpc-b-pv-table", var.infra_name)
    }
}

resource "aws_route" "public_internet_gateway_b" {
  route_table_id         = aws_route_table.public_table_b.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_b.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "tgw_b_to_a" {
  route_table_id         = aws_route_table.public_table_b.id
  destination_cidr_block = var.cidr_block_a
  transit_gateway_id = module.tgw.tgw_id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "tgw_b_to_c" {                           #Estou criando a rota na route table, mas vou impedir
  route_table_id         = aws_route_table.public_table_b.id  #a propagação da TGW associada à VPC B para a VPC C.
  destination_cidr_block = var.cidr_block_c                   #Assim, elas não poderão se falar.
  transit_gateway_id = module.tgw.tgw_id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "private_internet_gateway_b" {
  route_table_id         = aws_route_table.private_table_b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id             = aws_nat_gateway.nat_b.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "public_b"{  
   count = 4
   subnet_id = aws_subnet.vpc-public-subnet-b[count.index].id
   route_table_id = aws_route_table.public_table_b.id

   depends_on = [
     aws_subnet.vpc-public-subnet-b,
     aws_vpc.infra_vpc_b
   ]
}

resource "aws_route_table_association" "private_b"{  
   count = 4
   subnet_id = aws_subnet.vpc-private-subnet-b[count.index].id
   route_table_id = aws_route_table.private_table_b.id

   depends_on = [
     aws_subnet.vpc-private-subnet-b,
     aws_vpc.infra_vpc_b
   ]
}
######################################################################################

#Route Tables e Associations da VPC C

resource "aws_route_table" "public_table_c" {
  vpc_id = aws_vpc.infra_vpc_c.id
  
  depends_on = [
    aws_vpc.infra_vpc_c
    ]
  
  tags = {
    Name = format("%s-vpc-c-pb-table", var.infra_name)
    }
}

resource "aws_route_table" "private_table_c" {
  vpc_id = aws_vpc.infra_vpc_c.id

  depends_on = [
    aws_vpc.infra_vpc_c
  ]

    tags = {
    Name = format("%s-vpc-c-pv-table", var.infra_name)
    }
}

resource "aws_route" "public_internet_gateway_c" {
  route_table_id         = aws_route_table.public_table_c.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_c.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "tgw_c_to_a" {
  route_table_id         = aws_route_table.public_table_c.id
  destination_cidr_block = var.cidr_block_a
  transit_gateway_id = module.tgw.tgw_id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "tgw_c_to_b" {                           #Estou criando a rota na route table, mas vou impedir
  route_table_id         = aws_route_table.public_table_c.id  #a propagação da TGW associada à VPC C para a VPC B.
  destination_cidr_block = var.cidr_block_b                   #Assim, elas não poderão se falar.
  transit_gateway_id = module.tgw.tgw_id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "private_internet_gateway_c" {
  route_table_id         = aws_route_table.private_table_c.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id             = aws_nat_gateway.nat_c.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "public_c"{  
   count = 4
   subnet_id = aws_subnet.vpc-public-subnet-c[count.index].id
   route_table_id = aws_route_table.public_table_c.id

   depends_on = [
     aws_subnet.vpc-public-subnet-c,
     aws_vpc.infra_vpc_c
   ]
}

resource "aws_route_table_association" "private_c"{  
   count = 4
   subnet_id = aws_subnet.vpc-private-subnet-c[count.index].id
   route_table_id = aws_route_table.private_table_c.id

   depends_on = [
     aws_subnet.vpc-private-subnet-c,
     aws_vpc.infra_vpc_c
   ]
}
