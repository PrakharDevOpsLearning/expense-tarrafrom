env               = "dev"
instance_type     = "t3.small"
#ssh_user          = "ec2-user"
#ssh_pass          = "DevOps321"
zone_id           = "Z060116124ZEQOTIK4GLZ"

#VPC Code Block

frontend_subnet            = ["10.10.0.0/27","10.10.0.32/27"]
backend_subnet             = ["10.10.0.64/27","10.10.0.96/27"]
db_subnet                  = ["10.10.0.128/27","10.10.0.160/27"]
public_subnets             = ["10.10.0.192/27","10.10.0.224/27"]
availability_zone          = ["us-east-1a","us-east-1b"]

vpc_cidr_block             = "10.10.0.0/24"
default_vpc_cidr           = "172.31.0.0/16"
default_vpc_Id             = "vpc-0134c6f29cb5ed837"
default_vpc_route_table_id = "rtb-0bbbeb0537edf6359"