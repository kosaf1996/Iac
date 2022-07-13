#vars 의 IAM User  변수를 이용해 user 생성 
resource "aws_iam_user" "example" {
  count = "${length(var.user_names)}" #List 의 길이를 반환
  name  = "${element(var.user_names, count.index)}" #var.user_names[count] 문법과 같음 
}

#IAM 사용자 정책 관리 
resource "aws_iam_policy" "ec2_read_only" {
  name   = "ec2-read-only"
  policy = "${data.aws_iam_policy_document.ec2_read_only.json}" #IAM 사용자 정책 json 출력
}

#IAM 사용자 정책 
data "aws_iam_policy_document" "ec2_read_only" {
  statement {
    effect    = "Allow" #허용
    actions   = ["ec2:Describe*"] #EC2 로 시작하는 모든  API 
    resources = ["*"] #모든 리소스
  }
}

#새로운 IAM 사용자에게 모든 정책 할당 
resource "aws_iam_user_policy_attachment" "ec2_access" {
  count      = "${length(var.user_names)}" #user length 반환 
  user       = "${element(aws_iam_user.example.*.name, count.index)}" #user
  policy_arn = "${aws_iam_policy.ec2_read_only.arn}" #정책 관리 함수
}

#새로운 IAM 사용자에게 읽기 정책 할당
resource "aws_iam_policy" "cloudwatch_read_only" {
  name   = "cloudwatch-read-only"
  policy = "${data.aws_iam_policy_document.cloudwatch_read_only.json}"
}

#cloudwatch 정책
data "aws_iam_policy_document" "cloudwatch_read_only" {
  statement {
    effect    = "Allow"
    actions   = ["cloudwatch:Describe*", "cloudwatch:Get*", "cloudwatch:List*"]
    resources = ["*"]
  }
}

#IAM 사용자 neo 에게 cloudwatch 접근 정책 
resource "aws_iam_policy" "cloudwatch_full_access" {
  name   = "cloudwatch-full-access" #정책명
  policy = "${data.aws_iam_policy_document.cloudwatch_full_access.json}" #json 형식으로 함수 호출 
}

data "aws_iam_policy_document" "cloudwatch_full_access" {
  statement { 
    effect    = "Allow" #허용
    actions   = ["cloudwatch:*"] #cloudwatch
    resources = ["*"] #모든 리소스 
  }
}

#cloudwatch 전체 액세스 허용 
resource "aws_iam_user_policy_attachment" "neo_cloudwatch_full_access" { 
  count = var.give_neo_cloudwatch_full_access #변수 받아오기 

  user       = "${aws_iam_user.example.0.name}" #neo 유저
  policy_arn = "${aws_iam_policy.cloudwatch_full_access.arn}" #정책의 ARN 으로 연결 
}

#cloudwatch 읽기 권한 허용 
resource "aws_iam_user_policy_attachment" "neo_cloudwatch_read_only" {
  count = 1 - var.give_neo_cloudwatch_full_access

  user       = "${aws_iam_user.example.0.name}"
  policy_arn = "${aws_iam_policy.cloudwatch_read_only.arn}"
}
