provider "aws" {
  alias = "mgmt"
}

provider "aws" {
  alias = "env"

  assume_role {
    role_arn = "arn:aws:iam::${var.env_acct_id}:role/${var.iam_role_name}"
  }
}
