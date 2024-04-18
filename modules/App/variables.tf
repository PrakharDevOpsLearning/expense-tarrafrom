variable "env" {}
variable "instance_type" {}
#variable "ssh_user" {}
#variable "ssh_pass" {}
variable "zone_id" {}
variable "component" {}
variable "subnets" {}
variable "vpc_id" {}
variable "vault_token" {}

variable "bastian_nodes" {}
variable "prometheus_nodes" {}
variable "server_app_port_sg_cidr" {}
variable "certificate_arn"{
  default = null
}

variable "lb_app_port_sg_cidr" {
  default = []
}

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

variable "lb_ports" {
  default = {}
}