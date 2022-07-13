
module "webserver_cluster" {
  source = "../../../../modules/services/webserver-cluster"

  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "${var.db_remote_state_bucket}"
  db_remote_state_key    = "${var.db_remote_state_key}"

  instance_type        = "t2.micro"
  min_size             = 2
  max_size             = 10
  enable_autoscaling   = 1 #시간별 조절 활성화 
  enable_new_user_data = 1 #sh 선택 
}
