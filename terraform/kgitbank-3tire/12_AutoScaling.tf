#시작 그룹
resource "aws_launch_configuration" "gmgu_autola" {
    name = "gmgu-autola"
    image_id = aws_ami_from_instance.gmgu-ami.id
    instance_type = "t2.micro"
    iam_instance_profile = "admin_role" #IAM Role
    security_groups = [aws_security_group.gmgu_sg.id]
    key_name = "gmgu-key"
    user_data = <<-EOF
                #! /bin/bash
                systemctl start httpd
                systemctl enabled httpd
                EOF
}

#배치 그룹 -> 클러스터, 분산, 파티션이 있다. 
resource "aws_placement_group" "gmgu_pg" {
    name = "gmgu-pg"
    strategy = "cluster"
  
}

#AutoScaling Group
resource "aws_autoscaling_group" "gmgu_atsg" {
    name = "gmgy-atsg"
    min_size = 2
    max_size = 10
    health_check_grace_period = 60 #60초 후부터 체크
    health_check_type = "EC2"
    desired_capacity = 2
    force_delete = false
    launch_configuration = aws_launch_configuration.gmgu_autola.name
    vpc_zone_identifier = [ aws_subnet.gmgu_weba.id,  aws_subnet.gmgu_webc.id ]
}

#AutoScaling Target 그룹 
resource "aws_autoscaling_attachment" "gmgu_asatt" {
    autoscaling_group_name = aws_autoscaling_group.gmgu_atsg.id
    alb_target_group_arn = aws_lb_target_group.gmgu_target.arn
}