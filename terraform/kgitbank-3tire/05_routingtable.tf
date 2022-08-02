#라우팅 테이블 생성
resource "aws_route_table" "gmgu_rt" {
    vpc_id = aws_vpc.gmgu_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gmgu_ig.id
    }
    tags = {
      "Name" = "gmgu-rt"
    }
}

#weba 서브넷 인터넷 게이트웨이를 통한 라우팅
resource "aws_route_table_association" "gmgu_rtass_a" {
    subnet_id = aws_subnet.gmgu_weba.id
    route_table_id = aws_route_table.gmgu_rt.id
  
}

#webc 서브넷 인터넷 게이트웨이를 통한 라우팅
resource "aws_route_table_association" "gmgu_rtass_c" {
    subnet_id = aws_subnet.gmgu_webc.id
    route_table_id = aws_route_table.gmgu_rt.id
  
}
