#TGW Route Tables: Uma por VPC para estabelecer o controle de tráfego

resource "aws_ec2_transit_gateway_route_table" "tgw_rt_a" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  tags               = {
    Name             = "Route-Table-TGW-A"
  }
  depends_on = [aws_ec2_transit_gateway.tgw]
}

resource "aws_ec2_transit_gateway_route_table" "tgw_rt_b" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  tags               = {
    Name             = "Route-Table-TGW-B"
  }
  depends_on = [aws_ec2_transit_gateway.tgw]
}

resource "aws_ec2_transit_gateway_route_table" "tgw_rt_c" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  tags               = {
    Name             = "Route-Table-TGW-C"
  }
  depends_on = [aws_ec2_transit_gateway.tgw]
}
################################################################

#TGW Route Table association com as VPCs - Público

resource "aws_ec2_transit_gateway_route_table_association" "tgw_rt_a_vpc_a_assoc" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_vpc_a_pb.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt_a.id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.tgw_attach_vpc_a_pb]
}

resource "aws_ec2_transit_gateway_route_table_association" "tgw_rt_b_vpc_b_assoc" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_vpc_b_pb.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt_b.id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.tgw_attach_vpc_b_pb]
}

resource "aws_ec2_transit_gateway_route_table_association" "tgw_rt_c_vpc_c_assoc" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_vpc_c_pb.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt_c.id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.tgw_attach_vpc_c_pb]
}
################################################################

#TGW Route Table propagation com as VPCs - Público

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw_rt_b_pb_to_vpc_a" {              #A falará com B
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_vpc_a_pb.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt_b.id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.tgw_attach_vpc_a_pb]
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw_rt_c_pb_to_vpc_a" {             #A falará com C
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_vpc_a_pb.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt_c.id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.tgw_attach_vpc_a_pb]
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw_rt_a_pb_to_vpc_b" {             #B falará com A
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_vpc_b_pb.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt_a.id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.tgw_attach_vpc_b_pb]
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw_rt_a_pb_to_vpc_c" {             ##C falará com A
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_vpc_c_pb.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt_a.id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.tgw_attach_vpc_c_pb]
}
