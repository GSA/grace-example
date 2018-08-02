provider "aws" {
  alias = "mgmt"

  assume_role {
    role_arn = "arn:aws:iam::${var.mgmt_account_id}:role/${var.iam_role_name}"
  }
}

resource "aws_iam_access_key" "mgmt_deployer" {
  provider = "aws.mgmt"
  user     = "${aws_iam_user.mgmt_deployer.name}"
}

resource "aws_iam_user" "mgmt_deployer" {
  provider = "aws.mgmt"
  name     = "circle-mgmt-deployer"
}

resource "aws_iam_user_policy_attachment" "mgmt_deployer_attach" {
  provider = "aws.mgmt"
  user     = "${aws_iam_user.mgmt_deployer.name}"

  # AWS-managed policy
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

resource "aws_iam_user_policy" "mgmt_deployer_org" {
  provider = "aws.mgmt"
  name     = "mgmt_deployer_org"
  user     = "${aws_iam_user.mgmt_deployer.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sts:AssumeRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
