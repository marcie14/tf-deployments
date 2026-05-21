provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source = "github.com/marcie14/tf-modules//modules/vpc?ref=vpc-v1.0.0"

  name        = "marciedev-prod"
  environment = "prod"

  cidr_block           = "10.2.0.0/16"
  public_subnet_cidrs  = ["10.2.1.0/24", "10.2.2.0/24"]
  private_subnet_cidrs = ["10.2.101.0/24", "10.2.102.0/24"]
  availability_zones   = ["us-east-2a", "us-east-2b"]
  enable_nat_gateway   = true
}

module "ecs" {
  source = "github.com/marcie14/tf-modules//modules/ecs-service?ref=ecs-service-v1.0.0"

  name        = "marciedev-prod"
  environment = "prod"

  container_image = "containous/whoami"
  container_port  = 80

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids

  desired_count = 2
  cpu           = 512
  memory        = 1024
  min_capacity  = 2
  max_capacity  = 6
}
