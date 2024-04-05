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

  vpc_cidr_block             = var.vpc_cidr_block
  env                        = var.env

  frontend_subnet            = var.frontend_subnet
  backend_subnet             = var.backend_subnet
  db_subnet                  = var.db_subnet
  availability_zone          = var.availability_zone

  default_vpc_cidr           = var.default_vpc_cidr
  default_vpc_Id             = var.default_vpc_Id
  default_vpc_route_table_id = var.default_vpc_route_table_id
}
