module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  aws_region           = var.aws_region
  availability_zones   = var.availability_zones
  availability_mode    = var.availability_mode
  public_subnet_cidrs  = var.public_subnet_cidrs
  public_subnet_names  = var.public_subnet_names
  private_subnet_cidrs = var.private_subnet_cidrs
  private_subnet_names = var.private_subnet_names
}

module "sg" {
  source         = "./modules/sg"
  vpc_id         = module.vpc.vpc_id
  alb_name       = var.alb_name
  container_port = var.container_port
}

module "alb" {
  source                = "./modules/alb"
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  certificate_arn       = module.acm.certificate_arn
  alb_security_group_id = module.sg.alb_security_group_id
  alb_name              = var.alb_name
}

module "acm" {
  source       = "./modules/acm"
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
  zone_id      = var.route53_zone_id
  domain_name  = var.domain_name
}

module "ecs" {
  source                             = "./modules/ecs"
  vpc_id                             = module.vpc.vpc_id
  private_subnet_ids                 = module.vpc.private_subnet_ids
  ecs_cluster_name                   = var.cluster_name
  ecs_security_group_id              = module.sg.ecs_security_group_id
  container_image                    = var.container_image
  container_port                     = var.container_port
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  alb_tg_arn                         = module.alb.alb_tg_arn
  alb_load_balancer_arn              = module.alb.alb_arn
  family_name                        = var.family_name
  network_mode                       = var.network_mode
  requires_compatibilities           = var.requires_compatibilities
  cpu                                = var.cpu
  memory                             = var.memory
  desired_count                      = var.desired_count
  ecs_service_name                   = var.ecs_service_name
  container_name                     = var.container_name
  aws_iam_role_name                  = var.aws_iam_role_name
  policy_arn                         = var.policy_arn
  launch_type                        = var.launch_type
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = "threat-composer-repository"
}
