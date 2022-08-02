#EC2 인스턴스 생성 
resource "aws_instance" "gmgu_ec2" {
  ami = "ami-0fd0765afb77bcca7"
  instance_type = "t2.micro"
  key_name = "gmgu-key"
  vpc_security_group_ids = [aws_security_group.gmgu_sg.id ]
  availability_zone = "ap-northeast-2a"
  subnet_id = aws_subnet.gmgu_weba.id
  associate_public_ip_address = true 
  user_data = file("user_data.sh")
}