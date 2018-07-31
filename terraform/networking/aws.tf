provider "aws" {
  region = "${var.default_region}"
}

provider "aws" {
  alias  = "env"
  region = "${var.env_region}"

  assume_role {
    role_arn = "arn:aws:iam::${var.env_account_id}:role/${var.iam_role_name}"
  }
}

provider "aws" {
  alias  = "mgmt"
  region = "${var.mgmt_region}"

  # assume_role {
  #   role_arn = "arn:aws:iam::${var.mgmt_account_id}:role/${var.iam_role_name}"
  # }
}
