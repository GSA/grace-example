variable "mgmt_account_id" {}

variable "env_account_id" {}

variable "mgmt_region" {
  default = "us-east-1"
}

variable "env_region" {
  default = "us-east-1"
}

variable "default_region" {
  default = "us-east-1"
}

variable "env_az_1" {
  default = "us-east-1b"
}

variable "env_az_2" {
  default = "us-east-1c"
}

variable "mgmt_az_1" {
  default = "us-east-1d"
}

variable "mgmt_az_2" {
  default = "us-east-1f"
}

variable "mgmt_cidr" {
  default = "10.0.0.0/16"
}

variable "env_cidr" {
  default = "10.1.0.0/16"
}

variable "iam_role_name" {
  default = "OrganizationAccountAccessRole"
}
