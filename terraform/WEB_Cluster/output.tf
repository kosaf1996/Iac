output "elb_dns_name" { #elb dns
  value = "${aws_elb.example.dns_name}"
}