module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name                 = "rds-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_db_subnet_group" "rds-subnet-group" {
  name       = "rds-subnet-group"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "rds-subnet-group"
    Project = "rds-subnets"
    Customer = "rds"
  }
}
