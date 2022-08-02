resource "aws_key_pair" "gmgy_key" {
    key_name = "gmgu-key"
    public_key = file("../../../../Users/GM/.ssh/gmgu.pub")
}