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

resource "aws_route" "public_tgw_a_to_b" {
  route_table_id         = aws_route_table.public_table_a.id
  destination_cidr_block = var.cidr_block_b
  transit_gateway_id = module.tgw.tgw_id

  timeouts {
    create = "5m"
  }

  depends_on = [
    module.tgw.tgw_id,
    module.tgw.tgw_attach_a
  ]
}

resource "aws_route" "public_tgw_a_to_c" {
  route_table_id         = aws_route_table.public_table_a.id
  destination_cidr_block = var.cidr_block_c
  transit_gateway_id = module.tgw.tgw_id
  
  timeouts {
    create = "5m"
  }

  depends_on = [
    module.tgw.tgw_id,
    module.tgw.tgw_attach_a
  ]
}

resource "aws_route" "private_internet_gateway_a" {
  route_table_id         = aws_route_table.private_table_a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id             = aws_nat_gateway.nat_a.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "private_a_to_b" {
  route_table_id         = aws_route_table.private_table_a.id
  destination_cidr_block = var.cidr_block_b
  transit_gateway_id           = module.tgw.tgw_id

  timeouts {
    create = "5m"
  }

    depends_on = [
    module.tgw.tgw_id,
    module.tgw.tgw_attach_a
  ]
}

resource "aws_route" "private_a_to_c" {
  route_table_id         = aws_route_table.private_table_a.id
  destination_cidr_block = var.cidr_block_c
  transit_gateway_id         = module.tgw.tgw_id

  timeouts {
    create = "5m"
  }

  depends_on = [
    module.tgw.tgw_id,
    module.tgw.tgw_attach_a
  ]
}

resource "aws_route_table_association" "public_a"{  
   count = length(var.public_subnets_a)
   subnet_id = aws_subnet.vpc-public-subnet-a[count.index].id
   route_table_id = aws_route_table.public_table_a.id

   depends_on = [
     aws_subnet.vpc-public-subnet-a,
     aws_vpc.infra_vpc_a
   ]
}

resource "aws_route_table_association" "private_a"{  
   count = length(var.private_subnets_a)
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

resource "aws_route" "public_tgw_b_to_a" {
  route_table_id         = aws_route_table.public_table_b.id
  destination_cidr_block = var.cidr_block_a
  transit_gateway_id = module.tgw.tgw_id

  timeouts {
    create = "5m"
  }

  depends_on = [
    module.tgw.tgw_id,
    module.tgw.tgw_attach_b
  ]
}

resource "aws_route" "public_tgw_b_to_c" {                    # Mesmo com essa rota definida, não propagarei a tabela
  route_table_id         = aws_route_table.public_table_b.id  # da route TGW de B para C. Assim, elas nao se falarão
  destination_cidr_block = var.cidr_block_c
  transit_gateway_id = module.tgw.tgw_id

  timeouts {
    create = "5m"
  }

  depends_on = [
    module.tgw.tgw_id,
    module.tgw.tgw_attach_b
  ]  
}

resource "aws_route" "private_internet_gateway_b" {
  route_table_id         = aws_route_table.private_table_b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id             = aws_nat_gateway.nat_b.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "private_b_to_a" {
  route_table_id         = aws_route_table.private_table_b.id
  destination_cidr_block = var.cidr_block_a
  transit_gateway_id           = module.tgw.tgw_id

  timeouts {
    create = "5m"
  }

  depends_on = [
    module.tgw.tgw_id,
    module.tgw.tgw_attach_b
  ]  
}

resource "aws_route" "private_b_to_c" {                       # Mesmo com essa rota definida, não propagarei a tabela
  route_table_id         = aws_route_table.private_table_b.id # da route TGW de B para C. Assim, elas nao se falarão
  destination_cidr_block = var.cidr_block_c
  transit_gateway_id         = module.tgw.tgw_id

  timeouts {
    create = "5m"
  }

  depends_on = [
    module.tgw.tgw_id,
    module.tgw.tgw_attach_b
  ]  
}

resource "aws_route_table_association" "public_b"{  
   count = length(var.public_subnets_b)
   subnet_id = aws_subnet.vpc-public-subnet-b[count.index].id
   route_table_id = aws_route_table.public_table_b.id

   depends_on = [
     aws_subnet.vpc-public-subnet-b,
     aws_vpc.infra_vpc_b
   ]
}

resource "aws_route_table_association" "private_b"{  
   count = length(var.private_subnets_b)
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

resource "aws_route" "public_tgw_c_to_a" {
  route_table_id         = aws_route_table.public_table_c.id
  destination_cidr_block = var.cidr_block_a
  transit_gateway_id = module.tgw.tgw_id

  timeouts {
    create = "5m"
  }

  depends_on = [
    module.tgw.tgw_id,
    module.tgw.tgw_attach_c
  ]
}

resource "aws_route" "public_tgw_c_to_b" {                    # Mesmo com essa rota definida, não propagarei a tabela
  route_table_id         = aws_route_table.public_table_c.id  # da route TGW de B para C. Assim, elas nao se falarão
  destination_cidr_block = var.cidr_block_b
  transit_gateway_id = module.tgw.tgw_id

  timeouts {
    create = "5m"
  }

  depends_on = [
    module.tgw.tgw_id,
    module.tgw.tgw_attach_c
  ]
}

resource "aws_route" "private_internet_gateway_c" {
  route_table_id         = aws_route_table.private_table_c.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id             = aws_nat_gateway.nat_c.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "private_c_to_a" {
  route_table_id         = aws_route_table.private_table_c.id
  destination_cidr_block = var.cidr_block_a
  transit_gateway_id     = module.tgw.tgw_id

  timeouts {
    create = "5m"
  }

  depends_on = [
    module.tgw.tgw_id,
    module.tgw.tgw_attach_c
  ]
}

resource "aws_route" "private_c_to_b" {                       # Mesmo com essa rota definida, não propagarei a tabela
  route_table_id         = aws_route_table.private_table_c.id # da route TGW de B para C. Assim, elas nao se falarão
  destination_cidr_block = var.cidr_block_b
  transit_gateway_id         = module.tgw.tgw_id

  timeouts {
    create = "5m"
  }

  depends_on = [
    module.tgw.tgw_id,
    module.tgw.tgw_attach_c
  ]
}

resource "aws_route_table_association" "public_c"{  
   count = length(var.public_subnets_c)
   subnet_id = aws_subnet.vpc-public-subnet-c[count.index].id
   route_table_id = aws_route_table.public_table_c.id

   depends_on = [
     aws_subnet.vpc-public-subnet-c,
     aws_vpc.infra_vpc_c
   ]
}

resource "aws_route_table_association" "private_c"{  
   count = length(var.private_subnets_c)
   subnet_id = aws_subnet.vpc-private-subnet-c[count.index].id
   route_table_id = aws_route_table.private_table_c.id

   depends_on = [
     aws_subnet.vpc-private-subnet-c,
     aws_vpc.infra_vpc_c
   ]
}
