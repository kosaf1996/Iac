#ALB 생성 
resource "aws_lb" "gmgu-alb" {
  name               = "gmgu-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.gmgu_sg.id]
  subnets            = [aws_subnet.gmgu_weba.id, aws_subnet.gmgu_webc.id]

  tags = {
    "Name" = "gmgu-alb"
  }
}

#ALB 리스너 설정
#Frontend
resource "aws_lb_listener" "gmgu_lb_listener" {
  load_balancer_arn = aws_lb.gmgu-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.gmgu_target.arn
  }

}

#ALB 타겟 그룹 
#BackEnd
resource "aws_lb_target_group" "gmgu_target" {
  name     = "gmgu-albtg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.gmgu_vpc.id

  health_check {
    enabled = true
    healthy_threshold = 3
    interval = 5
    matcher = "200"
    path = "/health.html"
    port = "traffic-port"
    protocol = "HTTP"
    timeout = 2
    unhealthy_threshold = 3
  }
}

#ALB 대상 등록
# resource "aws_lb_target_group_attachment" "gmgu-lb-att" {
#     target_group_arn = aws_lb_target_group.gmgu_target.arn
#     target_id = aws_instance.gmgu_ec2.id
#     port = "${var.port}"
# }