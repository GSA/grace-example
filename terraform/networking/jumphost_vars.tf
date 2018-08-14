variable "deployer_public_key_path" {
  default     = ""
  description = "Path to a public key to use for deployment. Defaults to the public key checked into the repository."
}

variable "jumphost_remote_access_cidr" {
  default     = "0.0.0.0/0"
  description = "CIDR block to allow access to Jumphosts"
}

variable "jumphost_instance_type" {
  default     = "t2.small"
  description = "AWS EC2 instance type for Jumphosts"
}

variable "num_jumphosts" {
  default     = "2"
  description = "Number of Jumphosts"
}
