#가용영역 a,c 에 public, private subnet 생성

#서브넷 weba
resource "aws_subnet" "gmgu_weba" {
    vpc_id = aws_vpc.gmgu_vpc.id
    cidr_block = "20.0.0.0/24"
    availability_zone = "ap-northeast-2a"
    tags = {
      "Name" = "gmgu-weba"
    }
  
}

#서브넷 webc
resource "aws_subnet" "gmgu_webc" {
    vpc_id = aws_vpc.gmgu_vpc.id
    cidr_block = "20.0.1.0/24"
    availability_zone = "ap-northeast-2c"
    tags = {
      "Name" = "gmgu-webc"
    }
  
}

#서브넷 wasa
resource "aws_subnet" "gmgu_wasa" {
    vpc_id = aws_vpc.gmgu_vpc.id
    cidr_block = "20.0.2.0/24"
    availability_zone = "ap-northeast-2a"

    tags = {
      "Name" = "gmgu-wasa"
    }
  
}

#서브넷 wasc
resource "aws_subnet" "gmgu_wasc" {
    vpc_id = aws_vpc.gmgu_vpc.id
    cidr_block = "20.0.3.0/24"
    availability_zone = "ap-northeast-2c"
    tags = {
      "Name" = "gmgu-wasc"
    }
  
}

#서브넷 dba
resource "aws_subnet" "gmgu_dba" {
    vpc_id = aws_vpc.gmgu_vpc.id
    cidr_block = "20.0.4.0/24"
    availability_zone = "ap-northeast-2a"
    tags = {
      "Name" = "gmgu-dba"
    }
}

#서브넷 dbc
resource "aws_subnet" "gmgu_dbc" {
    vpc_id = aws_vpc.gmgu_vpc.id
    cidr_block = "20.0.5.0/24"
    availability_zone = "ap-northeast-2c"
    tags = {
      "Name" = "gmgu-dbc"
    }
  
}