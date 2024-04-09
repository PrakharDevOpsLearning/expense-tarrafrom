module "frontend" {
  depends_on = [module.backend]

  source        = "./modules/App"
  instance_type = var.instance_type
  zone_id       = var.zone_id
  component     = "frontend"
  env           = var.env
  vault_token   = var.vault_token

  vpc_id        = module.vpc.vpc_id
  subnets       = module.vpc.frontend_subnets
}

module "backend" {
  depends_on    = [module.mysql]

  source        = "./modules/App"
  instance_type = var.instance_type
  component     = "backend"
  zone_id       = var.zone_id
  env           = var.env
  vault_token   = var.vault_token

  vpc_id        = module.vpc.vpc_id
  subnets       = module.vpc.backend_subnets
}

module "mysql" {

  source        = "./modules/App"
  instance_type = var.instance_type
  component     = "mysql"
  zone_id       = var.zone_id
  env           = var.env
  vault_token   = var.vault_token

  vpc_id        = module.vpc.vpc_id
  subnets       = module.vpc.db_subnets
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block             = var.vpc_cidr_block
  env                        = var.env

  frontend_subnet            = var.frontend_subnet
  backend_subnet             = var.backend_subnet
  db_subnet                  = var.db_subnet
  public_subnets             = var.public_subnets
  availability_zone          = var.availability_zone

  default_vpc_cidr           = var.default_vpc_cidr
  default_vpc_Id             = var.default_vpc_Id
  default_vpc_route_table_id = var.default_vpc_route_table_id
}
