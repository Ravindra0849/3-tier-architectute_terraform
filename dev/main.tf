
module "dev_vpc" {
  source      = "../modules/vpc"
  cidr_vpc    = "10.0.0.0/16"
  dns_support = true
  hostnames   = true
  tendency    = "default"
  env         = "dev"
  owner       = "DevOps"
  teamDL      = "devops12@gmail.com"
  project     = "3-tier"
}

module "dev_subnets" {
  source          = "../modules/subnets"
  vpc_id          = module.dev_vpc.vpc_id
  web_subnet_cidr = ["10.0.1.0/24", "10.0.2.0/24"]
  app_subnet_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
  db_subnet_cidr  = ["10.0.5.0/24", "10.0.6.0/24"]
  azs             = ["ap-south-1a", "ap-south-1b"]
  env             = "dev"
  owner           = "DevOps"
  teamDL          = "devops12@gmail.com"
  project         = "3-tier"
}


module "dev_Igw" {
  source  = "../modules/InternetGateway"
  vpc_id  = module.dev_vpc.vpc_id
  env     = "dev"
  owner   = "DevOps"
  teamDL  = "devops12@gmail.com"
  project = "3-tier"
}

module "dev_natGW" {
  source     = "../modules/natgw"
  azs        = ["ap-south-1a", "ap-south-1b"]
  subnet_ids = module.dev_subnets.web_subnet_ids
  env        = "dev"
  project    = "3-tier"
}

module "dev_routeTable" {
  source         = "../modules/routeTables"
  azs            = ["ap-south-1a", "ap-south-1b"]
  vpc_id         = module.dev_vpc.vpc_id
  env            = "dev"
  project        = "3-tier"
  igw_id         = module.dev_Igw.Igw_id
  nat_id         = module.dev_natGW.natgw_ids
  web_subnet_ids = module.dev_subnets.web_subnet_ids
  app_subnet_ids = module.dev_subnets.app_subnet_ids
  db_subnet_ids  = module.dev_subnets.db_subnet_ids
}

module "dev_sg" {
  source  = "../modules/securityGroups"
  vpc_id  = module.dev_vpc.vpc_id
  env     = "dev"
  project = "3-tier"
}

module "dev_LB" {
  source            = "../modules/loadBalancers"
  vpc_id            = module.dev_vpc.vpc_id
  env               = "dev"
  project           = "3-tier"
  web_subnet_ids    = module.dev_subnets.web_subnet_ids
  app_subnet_ids    = module.dev_subnets.app_subnet_ids
  external_lb_sg_id = module.dev_sg.external_lb_sg_id
  internal_lb_sg_id = module.dev_sg.internal_lb_sg_id
}

module "dev_asg" {
  source        = "../modules/autoScaling"
  env           = "dev"
  project       = "3-tier"
  ami_id        = "ami-0e35ddab05955cf57"
  instance_type = "t2.micro"
  key_name      = "devops_mumbai"
  web_subnets   = module.dev_subnets.web_subnet_ids
  app_subnets   = module.dev_subnets.app_subnet_ids
  web_tier_sg   = module.dev_sg.web_tier_sg_id
  app_tier_sg   = module.dev_sg.app_tier_sg_id
  web_tg_arn    = module.dev_LB.web_tg_arn
  app_tg_arn    = module.dev_LB.app_tg_arn
}

module "dev_db" {
  source         = "../modules/database"
  db_username    = "admin"
  db_password    = "admin#1234!99"
  env            = "dev"
  project        = "3-tier"
  subnet_ids     = module.dev_subnets.db_subnet_ids
  instance_class = "db.t3.medium"
  sg_id          = module.dev_sg.db_tier_sg_id
}



