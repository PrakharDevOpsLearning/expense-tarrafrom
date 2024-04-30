module "frontend" {
  depends_on              = [module.backend]

  source                  = "./modules/App"
  instance_type           = var.instance_type
  zone_id                 = var.zone_id
  component               = "frontend"
  env                     = var.env
  vault_token             = var.vault_token

  vpc_id                  = module.vpc.vpc_id
  subnets                 = module.vpc.frontend_subnets

  lb_subnets              = module.vpc.public_subnets
  lb_type                 = "public"
  lb_needed               =  "true"
  app_port                =  80
  bastian_nodes           = var.bastian_nodes
  prometheus_nodes        = var.prometheus_nodes
  server_app_port_sg_cidr = var.public_subnets
  lb_app_port_sg_cidr     = ["0.0.0.0/0"]
  certificate_arn         = var.certificate_arn
  lb_ports                = {http: 80, https: 443}

}

module "backend" {
  depends_on              = [module.rds]

  source                  = "./modules/App"
  instance_type           = var.instance_type
  component               = "backend"
  zone_id                 = var.zone_id
  env                     = var.env
  vault_token             = var.vault_token

  vpc_id                  = module.vpc.vpc_id
  subnets                 = module.vpc.backend_subnets

  lb_subnets              = module.vpc.backend_subnets
  lb_type                 = "private"
  lb_needed               =  "true"
  app_port                = 8080
  bastian_nodes           = var.bastian_nodes
  prometheus_nodes        = var.prometheus_nodes
  server_app_port_sg_cidr = concat(var.frontend_subnet, var.backend_subnet)
  lb_app_port_sg_cidr     = var.frontend_subnet
  lb_ports                = {http: 8080}
}


#module "mysql" {
#
#  source                  = "./modules/App"
#  instance_type           = var.instance_type
#  component               = "mysql"
#  zone_id                 = var.zone_id
#  env                     = var.env
#  vault_token             = var.vault_token
#
#  vpc_id                  = module.vpc.vpc_id
#  subnets                 = module.vpc.db_subnets
#  bastian_nodes           = var.bastian_nodes
#  prometheus_nodes        = var.prometheus_nodes
#  app_port                = 3306
#  server_app_port_sg_cidr = var.backend_subnet
#}

module "rds" {

  source                  = "./modules/rds"

  allocated_storage       = "20"
  component               = "rds"
  engine                  = "mysql"
  engine_version          = "8.0.36"
  env                     = var.env
  family                  = "mysql8.0"
  instance_class          = "db.t3.micro"
  server_app_port_sg_cidr = var.backend_subnet
  skip_final_snapshot     = "true"
  storage_type            = "gp3"
  subnet_ids              = module.vpc.db_subnets
  vpc_id                  = module.vpc.vpc_id
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
