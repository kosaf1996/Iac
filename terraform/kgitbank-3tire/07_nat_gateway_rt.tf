#Nat Gateway Routing Table 
resource "aws_route_table" "gmgy_nat_rt" {
    vpc_id = aws_vpc.gmgu_vpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.gmgu_ng.id
    }
    tags = {
      "Name" = "nat-gateway-rt"
    }
}

#wasa 서브넷 NAT 게이트웨이를 통한 라우팅
resource "aws_route_table_association" "gmgu_nat_rtass_wasa" {
    subnet_id = aws_subnet.gmgu_wasa.id
    route_table_id = aws_route_table.gmgy_nat_rt.id
}

#wasc 서브넷 NAT 게이트웨이를 통한 라우팅
resource "aws_route_table_association" "gmgu_nat_rtass_wasc" {
    subnet_id = aws_subnet.gmgu_wasc.id
    route_table_id = aws_route_table.gmgy_nat_rt.id
}

#dba 서브넷 NAT 게이트웨이를 통한 라우팅
resource "aws_route_table_association" "gmgu_nat_rtass_dba" {
    subnet_id = aws_subnet.gmgu_dba.id
    route_table_id = aws_route_table.gmgy_nat_rt.id
}

#dbc 서브넷 NAT 게이트웨이를 통한 라우팅
resource "aws_route_table_association" "gmgu_nat_rtass_dbc" {
    subnet_id = aws_subnet.gmgu_dbc.id
    route_table_id = aws_route_table.gmgy_nat_rt.id
}