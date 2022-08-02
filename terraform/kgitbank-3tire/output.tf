#EC2 인스턴스 주소 출력
output "public_ip" {
  value = aws_instance.gmgu_ec2.public_ip
}

#ALB 주소 출력 
output "dns_name" {
  value = aws_lb.gmgu-alb.dns_name
}

#DB 출력 
output "db_endpoint" {
  value = aws_db_instance.gmgu_mydb.endpoint
}