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
bastian_nodes              = ["172.31.4.94/32"]
prometheus_nodes           = ["172.31.85.41/32"]
availability_zone          = ["us-east-1a","us-east-1b"]

vpc_cidr_block             = "10.10.0.0/24"
default_vpc_cidr           = "172.31.0.0/16"
default_vpc_Id             = "vpc-0134c6f29cb5ed837"
default_vpc_route_table_id = "rtb-0bbbeb0537edf6359"
certificate_arn            ="arn:aws:acm:us-east-1:088743999046:certificate/53f1eb56-29e3-443f-837a-289829c1f1c9"
kms_key_id                 ="arn:aws:kms:us-east-1:088743999046:key/968b0bb5-1693-45ec-b4f4-977f331612f6"

#AGS

desired_capacity           = 1
max_capacity               = 5
min_capacity               = 1