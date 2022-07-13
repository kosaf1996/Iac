 #S3 버킷 생성 
    resource "aws_s3_bucket" "terraform_state" {
       #Bucket Name
      bucket = "${var.bucket_name}"
    
      versioning {       #버전관리
        enabled = true
      }

      lifecycle { 
        #삭제 보호 옵션이 적용되어있으면 오류가 발생한다
        #리소스 삭제방지 
        prevent_destroy = true
      }
    }

## =============================================================================
##  상태 파일 공유하기
## =============================================================================

terraform {
 backend "s3" {
   bucket = "terraform-repository-0001"
   key    = "terraform.tfstate"
   region = "ap-northeast-2"
   encrypt = true
   dynamodb_table = "terraform-repository-0001"
 }
}

## =============================================================================
##  상태 파일 잠금
## =============================================================================

resource "aws_dynamodb_table" "terraform_lock" {
#   var.tf 파일에 dynamodb_name에 대한 주석 해제  
   name = "${var.dynamodb_name}" #name
   hash_key = "LockID" #Key
   read_capacity  = 1 #read
   write_capacity = 1 #write

   attribute {
     name = "LockID"
     type = "S"
   }
}