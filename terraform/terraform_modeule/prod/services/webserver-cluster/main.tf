module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster" #모듈 재사용

  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "${var.db_remote_state_bucket}"
  db_remote_state_key    = "${var.db_remote_state_key}"

  instance_type = "m4.large"
  min_size      = 2
  max_size      = 10
}

#ASG 그룹 자동 크기 조정 
#오전 시간 동안 10대로 늘린다. 
resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scale-out-during-business-hours"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 10
  recurrence            = "0 9 * * *" #매일 오전 9시 

  autoscaling_group_name = "${module.webserver_cluster.asg_name}"
}

#오후 5시 부터 2개로 줄인다 
resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale-in-at-night"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 2
  recurrence            = "0 17 * * *" #매일 오후 5시

  autoscaling_group_name = "${module.webserver_cluster.asg_name}"
}
