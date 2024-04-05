#module "frontend" {
#  depends_on = [module.backend]
#
#  source        = "./modules/App"
#  instance_type = var.instance_type
#  ssh_user      = var.ssh_user
#  ssh_pass       = var.ssh_pass
#  zone_id       = var.zone_id
#  component     = "frontend"
#  env           = var.env
#}
#
#module "backend" {
#  depends_on    = [module.mysql]
#
#  source        = "./modules/App"
#  instance_type = var.instance_type
#  component     = "backend"
#  ssh_user      = var.ssh_user
#  ssh_pass       = var.ssh_pass
#  zone_id       = var.zone_id
#  env           = var.env
#}
#
#module "mysql" {
#
#  source        = "./modules/App"
#  instance_type = var.instance_type
#  component     = "mysql"
#  ssh_user      = var.ssh_user
#  ssh_pass       = var.ssh_pass
#  zone_id       = var.zone_id
#  env           = var.env
#}

module "vpc" {
  source = "./modules/vpc"

  cidr_block = var.cidr_block
  env        = var.env
}
