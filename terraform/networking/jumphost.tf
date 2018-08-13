variable "deployer_public_key_path" {
  default     = ""
  description = "Path to a public key to use for deployment. Defaults to the public key checked into the repository."
}

resource "aws_key_pair" "deployer" {
  key_name_prefix = "deployer-key"
  public_key      = "${var.deployer_public_key_path == "" ? file("${path.module}/files/deployer.pub") : var.deployer_public_key_path}"
}

data "aws_ami" "jumphost" {
  most_recent = true

  filter {
    name   = "name"
    values = ["jumphost *"]
  }

  owners = ["${var.mgmt_account_id}"]
}

resource "aws_cloudformation_stack" "jumphost" {
  name     = "jumphost-stack"
  provider = "aws.mgmt"

  template_url = "https://aws-quickstart.s3.amazonaws.com/quickstart-linux-bastion/templates/linux-bastion.template"
  capabilities = ["CAPABILITY_IAM"]

  parameters = {
    VPCID               = "${module.vpc_mgmt.vpc_id}"
    PublicSubnet1ID     = "${module.vpc_mgmt.public_subnets[0]}"
    PublicSubnet2ID     = "${module.vpc_mgmt.public_subnets[1]}"
    RemoteAccessCIDR    = "0.0.0.0/0"
    KeyPairName         = "${aws_key_pair.deployer.key_name}"
    BastionInstanceType = "t2.small"
    OSImageOverride     = "${data.aws_ami.jumphost.image_id}"
  }
}
