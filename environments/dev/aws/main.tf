provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source = "github.com/marcie14/tf-modules//modules/vpc?ref=vpc-v1.0.0"

  name        = "marciedev-dev"
  environment = "dev"

  cidr_block           = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
  availability_zones   = ["us-east-2a", "us-east-2b"]
  enable_nat_gateway   = false
}

module "ecs" {
  source = "github.com/marcie14/tf-modules//modules/ecs-service?ref=ecs-service-v1.0.0"

  name        = "marciedev-dev"
  environment = "dev"

  container_image = "containous/whoami"
  container_port  = 80

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.public_subnet_ids

  desired_count = 1
  cpu           = 256
  memory        = 512
  min_capacity  = 1
  max_capacity  = 2
}
