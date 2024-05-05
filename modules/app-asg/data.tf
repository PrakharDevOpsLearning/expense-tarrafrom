data "aws_ami" "image" {
  owners = ["973714476881"]
  most_recent = true
  name_regex = "RHEL-9-DevOps-Practice"
}

data "vault_generic_secret" "ssh" {
  path = "common/ssh"
}