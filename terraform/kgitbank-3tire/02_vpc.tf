#vpc 생성 
resource "aws_vpc" "gmgu_vpc" {
    cidr_block = "20.0.0.0/16"
    enable_dns_hostnames =  true
    enable_dns_support = true
    tags = {
      "Name" = "gmgu_vpc"
    }
}