

data "aws_availability_zones" "all" {}

resource "aws_instance" "example" {
  count             = "${var.num_availability_zones}"
  availability_zones   = ["ap-northeast-2a","ap-northeast-2c"]

  ami           = "ami-40d28157"
  instance_type = "t2.micro"
}
