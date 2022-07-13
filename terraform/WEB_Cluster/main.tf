#Auto Scaling Group 시작 구성 생성 
resource "aws_launch_configuration" "example" {
  image_id        = "ami-0ff91d792f1b9da38"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.instance.id}"]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World!!!" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  lifecycle {
    #오브젝트의 값을 교체 할 떄 값을 변경하지 못하는 오브젝트
    #대해서는 기존 오브젝트를 삭제한뒤 새로운 값의 오브젝트 생성
    create_before_destroy = true
  }
}

#Auto Scaling Group 생성 
resource "aws_autoscaling_group" "example" {
  launch_configuration = "${aws_launch_configuration.example.id}" #시작 구성 불러오기 
  availability_zones   = ["ap-northeast-2a","ap-northeast-2c"]
  load_balancers    = ["${aws_elb.example.name}"]
  health_check_type = "ELB" #상태 체크 

  min_size = 2 #최소
  max_size = 10 #최대

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}

#보안그룹 
resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = "${var.server_port}"
    to_port     = "${var.server_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_availability_zones" "all" {}

#ELB 배포 
resource "aws_elb" "example" {
  name               = "terraform-asg-example"
  availability_zones = ["ap-northeast-2a","ap-northeast-2c"]
  security_groups    = ["${aws_security_group.elb.id}"]

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "${var.server_port}"
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:${var.server_port}/"
  }
}

resource "aws_security_group" "elb" {
  name = "terraform-example-elb"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}