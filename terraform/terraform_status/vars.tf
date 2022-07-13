variable "bucket_name" {
  description ="The name of the S3 bucket. Must be globally unique"
  default = "terraform-repository-0001"
}

variable "dynamodb_name" {
 description = "The name of the Dynamodb table. Must be globally unique in your account."
 default = "terraform-repository-0001"
}
