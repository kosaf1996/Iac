#variable 입력 변수 설정 
#default 를 입력하지 않으면 대화형으로 진행할수 있다.
#입력 변수 모음 
variable "server_port" { #입력 변수
  description = "The port the server will use for HTTP requests" 
  default     = 8080 #변수 값
}

