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
  name                 = "MGMT-devsecops-networking-test"
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

# TODO: Add conditional with default of true for this
resource "aws_security_group" "mgmt_ec2_management_sg" {
  # Conditionally create this resource if value is true
  count = "${var.vpc_mgmt_set_default_ingress_rdp_ssh_rule == "true" ? 1 : 0}"

  name        = "${var.vpc_mgmt_ec2_management_sg_name}"
  description = "Tenant Security Group for managing instances"

  provider = "aws.mgmt"

  vpc_id = "${module.vpc_mgmt.vpc_id}"

  ingress {
    from_port   = "${var.mgmt_sg_ingress_rdp_port}"
    to_port     = "${var.mgmt_sg_ingress_rdp_port}"
    protocol    = "${var.mgmt_sg_ingress_rdp_protocol}"
    cidr_blocks = "${var.mgmt_sg_ingress_rdp_cidrs}"
  }

  ingress {
    from_port   = "${var.mgmt_sg_ingress_ssh_port}"
    to_port     = "${var.mgmt_sg_ingress_ssh_port}"
    protocol    = "${var.mgmt_sg_ingress_ssh_protocol}"
    cidr_blocks = "${var.mgmt_sg_ingress_ssh_cidrs}"
  }

  # egress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
}

resource "aws_security_group" "mgmt_ec2_egress_on_prem" {
  count = "${var.vpc_mgmt_set_default_egress_rule == "true" ? 1 : 0}"

  name        = "${var.vpc_mgmt_ec2_egress_on_prem_sg_name}"
  description = "Tenant security group for egress to on-prem"

  provider = "aws.mgmt"

  vpc_id = "${module.vpc_mgmt.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "${var.mgmt_ec2_egress_on_prem_all_traffic_cidrs}"
  }

  egress {
    from_port   = 25
    to_port     = 25
    protocol    = "tcp"
    cidr_blocks = "${var.mgmt_ec2_egress_on_prem_smtp_cidrs}"
  }
}

# TODO: NACL for private subnets

resource "aws_network_acl" "mgmt_private_nacl" {
  # TODO: Possible problem here with count as a conditional, need to test.
  count = "${var.vpc_mgmt_set_default_private_nacl == "true" ? 1 : 0}"

  vpc_id     = "${module.vpc_mgmt.vpc_id}"
  subnet_ids = ["${module.vpc_mgmt.private_subnets}"]

  provider = "aws.mgmt"

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.mgmt_private_nacl_ingress_cidrs}"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.mgmt_private_nacl_egress_cidrs}"
    from_port  = 0
    to_port    = 0
  }
}
