#AMI 생성
resource "aws_ami_from_instance" "gmgu-ami" {
    name = "gmgu-ami"
    source_instance_id = aws_instance.gmgu_ec2.id

    depends_on = [
      aws_instance.gmgu_ec2
    ]
}