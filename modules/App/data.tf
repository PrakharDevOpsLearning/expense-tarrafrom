data "aws_security_group" "selected" {
  name = "allow-all"
}

data "aws_ami" "image" {
  owners = ["973714476881"]
  most_recent = true
  name_regex = "RHEL-9-DevOps-Practice"
}