data "aws_ami" "image" {
  owners      = ["self"]
  most_recent = true
  name_regex  = "golden-ami-*"
}

data "vault_generic_secret" "ssh" {
  path = "common/ssh"
}