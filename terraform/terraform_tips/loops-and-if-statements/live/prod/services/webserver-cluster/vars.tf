variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket used for the database's remote state storage"
  default = "terraform-repository-0001" #terrform 상태관리 버킷
}

variable "db_remote_state_key" {
  description = "The name of the key in the S3 bucket used for the database's remote state storage"
  default = "live/prod/data-stores/mysql/terraform.tfstate" #s3 에 저장된 RDS tfstate 경로 
}


