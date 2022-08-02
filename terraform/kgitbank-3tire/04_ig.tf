#IG 생성
resource "aws_internet_gateway" "gmgu_ig" {
    vpc_id = aws_vpc.gmgu_vpc.id
    tags = {
      "Name" = "gmgu-ig"
    }
}