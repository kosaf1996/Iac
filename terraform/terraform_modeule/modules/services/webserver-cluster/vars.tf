variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default     = 8080
}

variable "cluster_name" { 
  description = "The name to use for all the cluster resources"
  default = "terraform"
}

variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket for the database's remote state"
  default = "terraform-repository-0001"
}

variable "db_remote_state_key" { #DB명 
  description = "The path for the database's remote state in S3"
  default = "LockID "
}

variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  default = "t2.micro"
}

variable "min_size" { #ASG 최소값
  description = "The minimum number of EC2 Instances in the ASG"
  default = "1"
}

variable "max_size" { #ASG 최대값
  description = "The maximum number of EC2 Insta nces in the ASG"
  default = "10"
}
