
resource "aws_db_instance" "example" {
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "example_database_prod"
  username            = "admin"
  password            = "${var.db_password}"
  skip_final_snapshot = true
}

terraform {
  backend "s3" {
    bucket = "terraform-repository-0001"
    key    = "live/prod/data-stores/mysql/terraform.tfstate"
    region = "ap-northeast-2"
    encrypt = true
    dynamodb_table = "terraform-repository-0001"
  }
}