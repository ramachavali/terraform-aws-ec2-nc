provider "aws" {
  region = "us-west-2"
}

provider "random" {}

data "aws_availability_zones" "available" {}

resource "random_pet" "random" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${random_pet.random.id}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "ec2" {
  name   = "${random_pet.random.id}-education_sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.80.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${random_pet.random.id}-education_sg"
  }
}
