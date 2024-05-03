variable "env" {}
variable "instance_type" {}
#variable "ssh_user" {}
#variable "ssh_pass" {}
variable "zone_id" {}
variable "vault_token" {}

#VPC Code Blocks

variable "frontend_subnet" {}
variable "backend_subnet" {}
variable "db_subnet" {}
variable "public_subnets" {}
variable "availability_zone" {}

variable "vpc_cidr_block" {}
variable "default_vpc_Id" {}
variable "default_vpc_cidr" {}
variable "default_vpc_route_table_id" {}
variable "bastian_nodes" {}
variable "prometheus_nodes" {}
variable "certificate_arn" {}
variable "kms_key_id" {}

