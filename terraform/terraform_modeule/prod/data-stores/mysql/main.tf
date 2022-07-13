resource "aws_db_instance" "example" {
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "example_database_prod"
  username            = "root"
  password            = "${var.db_password}"
  skip_final_snapshot = true
}

terraform {
  backend "s3" {
    bucket = "terraform-study-2022"
    key    = "prod/data-stores/mysql/terraform.tfstate"
    region = "ap-northeast-2"
    encrypt = true
#    dynamodb_table = "(생성한 DynamoDB 테이블 이름)"
  }
}
