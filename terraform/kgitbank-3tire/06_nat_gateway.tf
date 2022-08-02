#EIP 생성
resource "aws_eip" "gmgu_nat_ip" {
  vpc = true #vpc 에서 사용 
  tags = {
    Name = "NAT-gmgu-EIP"
  }
}

#natgateway 사용
resource "aws_nat_gateway" "gmgu_ng" {
    allocation_id = aws_eip.gmgu_nat_ip.id
    subnet_id = aws_subnet.gmgu_weba.id
    tags = {
      "Name" = "gmgu_NatGateway"
    }
  
}