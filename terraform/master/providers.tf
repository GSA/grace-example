terraform {
  backend "s3" {
    region = "us-east-1"
  }
}

provider "aws" {
  alias = "mgmt"
}

provider "aws" {
  alias = "env"

  assume_role {
    role_arn = "arn:aws:iam::${var.env_account_id}:role/${var.iam_role_name}"
  }
}
