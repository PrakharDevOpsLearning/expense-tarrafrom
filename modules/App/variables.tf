variable "env" {}
variable "instance_type" {}
#variable "ssh_user" {}
#variable "ssh_pass" {}
variable "zone_id" {}
variable "component" {}
variable "subnets" {}
variable "vpc_id" {}
variable "vault_token" {}

variable "app_port" {
  default = null
}


variable "lb_type" {
  default = null
}

variable "lb_subnets" {
  default = null
}

variable "lb_needed" {
  default = false
}