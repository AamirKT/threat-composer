module "vpc" {
  source = "./modules/vpc"
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
  alb_name = "threatcomposer-alb"
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  certificate_arn = module.acm.certificate_arn
  alb_security_group_id = module.sg.alb_security_group_id
}


module "acm" {
  source = "./modules/acm"
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id = module.alb.alb_zone_id
  zone_id = var.route53_zone_id
  domain_name = var.domain_name
}

module "ecs" {
  source = "./modules/ecs"
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  alb_tg_arn = module.alb.alb_tg_arn
  alb_load_balancer_arn = module.alb.alb_arn
  ecs_security_group_id = module.sg.ecs_security_group_id
  container_image = var.container_image
}

module "ecr" {
  source = "./modules/ecr"
  repository_name = "threatcomposer"
}