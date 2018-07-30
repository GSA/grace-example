provider "aws" {
  alias = "env"

  assume_role {
    role_arn = "arn:aws:iam::${var.env_account_id}:role/${var.iam_role_name}"
  }
}

resource "aws_iam_role" "env_deployer" {
  provider = "aws.env"
  name     = "circle-env-deployer"

  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
  {
    "Action": "sts:AssumeRole",
    "Principal": {
      "AWS": "arn:aws:iam::${var.mgmt_account_id}:user/circle-mgmt-deployer"
    },
    "Effect": "Allow",
    "Sid": ""
  }
]
}
EOF
}

resource "aws_iam_role_policy_attachment" "env_deployer_attach" {
  provider = "aws.env"
  role     = "${aws_iam_role.env_deployer.name}"

  # AWS-managed policy
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}
