module "vpc_mgmt" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "= 1.37.0"

  providers = {
    aws = "aws.mgmt"
  }

  azs                  = ["${var.mgmt_az_1}", "${var.mgmt_az_2}"]
  cidr                 = "${var.mgmt_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway   = false
  name                 = "mgmt-grace-networking-example"
  public_subnets       = ["${cidrsubnet(var.mgmt_cidr, 2, 0)}", "${cidrsubnet(var.mgmt_cidr, 2, 1)}"]
  private_subnets      = ["${cidrsubnet(var.mgmt_cidr, 2, 2)}", "${cidrsubnet(var.mgmt_cidr, 2, 3)}"]

  tags = {
    Terraform   = "true"
    Environment = "Management"
  }
}

module "mgmt_spoke" {
  source = "../spoke"

  providers = {
    aws = "aws.mgmt"
  }

  vpc_id = "${module.vpc_mgmt.vpc_id}"
}
