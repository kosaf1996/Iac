#IAM 사용자 생성 
resource "aws_iam_user" "example" {
  count = 3#loop 문 3명의 IAM 유저 생성 
  name = "neo.${count.index}" #count 가 증가함에 따라 다른 이름 으로 생성 neo.1,neo.2,neo.3
}
