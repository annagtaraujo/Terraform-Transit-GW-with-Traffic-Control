output "tgw_id"{
    value = aws_ec2_transit_gateway.tgw.id
}

output "tgw_attach_a"{
    value = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_vpc_a_pb.id
}

output "tgw_attach_b"{
    value = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_vpc_b_pb.id
}

output "tgw_attach_c"{
    value = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_vpc_c_pb.id
}