
#EC2
resource "aws_instance" "example" {
  ami                    = "" #AMI ID
  instance_type          = "t2.micro"              #instance_type
  vpc_security_group_ids = ["${aws_security_group.instance.id}"] #생성되는 보안그룹 ID

  #인스턴스 생성시 스크립트
  user_data =<<-EOF         
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF
  tags = {
    "name" = "terraform" #tag
  }
}
 
#보안 그룹
resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = "${var.server_port}" #vars 에 지정한 server_port
    to_port     = "${var.server_port}"
    protocol    = "tcp" #protocol 
    cidr_blocks = ["0.0.0.0/0"] #network cidr
  }
}
