#IAM User 의 리스트 
variable "user_names" {
  description = "Create IAM users with these names"
  type        = list
  default     = ["neo", "trinity", "morpheus"]
}

variable "give_neo_cloudwatch_full_access" {
  description = "If true, neo gets full access to CloudWatch"
  default = 0 #option
                #0 fill policy
                #1 read policy            
}
