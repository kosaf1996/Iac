#output 출력변수 
output "public_ip" { #terraform 실행후 public ip 출력
  value = "${aws_instance.example.public_ip}"
}