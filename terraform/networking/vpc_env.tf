module "vpc_env" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "= 1.37.0"

  providers = {
    aws = "aws.env"
  }

  azs                  = ["${var.env_az_1}", "${var.env_az_2}"]
  cidr                 = "${var.env_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway   = false
  name                 = "env-grace-networking-example"
  public_subnets       = ["${cidrsubnet(var.env_cidr, 2, 0)}", "${cidrsubnet(var.env_cidr, 2, 1)}"]
  private_subnets      = ["${cidrsubnet(var.env_cidr, 2, 2)}", "${cidrsubnet(var.env_cidr, 2, 3)}"]

  tags = {
    Terraform = "true"
  }
}

module "env_spoke" {
  source = "../spoke"

  providers = {
    aws = "aws.env"
  }

  vpc_id = "${module.vpc_env.vpc_id}"
}
