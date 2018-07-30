# Env VPC variables

variable "vpc_env_set_default_ingress_https_rule" {
  type        = "string"
  default     = "true"
  description = "Boolean value to define whether or not to create the default GRACE HTTPS ingress rule for an application security group in the environment VPC. Default: true"
}

variable "vpc_env_set_default_ingress_rdp_ssh_rule" {
  type        = "string"
  default     = "true"
  description = "Boolean value to define whether or not to create the default RDP/SSH ingress rule for an application security group in the environment VPC. Default: true"
}

variable "vpc_env_set_default_egress_rule" {
  type        = "string"
  default     = "true"
  description = "Boolean value to define whether or not to create the default egress rule for an application security group in the environment VPC. Default: true"
}

variable "vpc_env_set_default_public_nacl" {
  type        = "string"
  default     = "true"
  description = "Boolean value to define whether or not to create the default public subnet NACL for a GRACE environment VPC. Default: true"
}

variable "vpc_env_set_default_private_nacl" {
  type        = "string"
  default     = "true"
  description = "Boolean value to define whether or not to create the default private subnet NACL for a GRACE environment VPC. Default: true"
}

variable "vpc_env_ingress_https_sg_name" {
  type        = "string"
  description = "Name for the ingress https security group. Required."
}

variable "vpc_env_ingress_https_cidr" {
  default     = "0.0.0.0/0"
  type        = "string"
  description = "CIDR ranges to accept HTTPS traffic from. Default: 0.0.0.0/0 (everyone)"
}

variable "vpc_env_ec2_management_sg_name" {
  type        = "string"
  description = "Name for the management security group in the application environment VPC. Required."
}

variable "vpc_env_ec2_egress_on_prem_sg_name" {
  type        = "string"
  description = "Name for the egress security group for traffic outbound for on-prem. Required."
}

variable "env_ec2_egress_on_prem_smtp_cidrs" {
  type        = "list"
  description = "CIDR ranges for the on-prem SMTP servers. Type: list. Required."
}

variable "env_ec2_egress_on_prem_all_traffic_cidrs" {
  type        = "list"
  description = "CIDR ranges for outbound traffic to on-prem targets. Type: list. Required."
}

variable "env_sg_ingress_rdp_port" {
  type        = "string"
  default     = "3389"
  description = "RDP port. Default: 3389"
}

variable "env_sg_ingress_rdp_protocol" {
  type        = "string"
  default     = "tcp"
  description = "SSH port. Default: 22"
}

variable "env_sg_ingress_rdp_cidrs" {
  type        = "list"
  description = "CIDR ranges from which to accept RDP traffic. Type: list. Required."
}

variable "env_sg_ingress_ssh_port" {
  type        = "string"
  default     = "22"
  description = "SSH port. Default: 22"
}

variable "env_sg_ingress_ssh_protocol" {
  type        = "string"
  default     = "tcp"
  description = "SSH protocol. Default: tcp"
}

variable "env_sg_ingress_ssh_cidrs" {
  type        = "list"
  description = "CIDR ranges from which to accept SSH traffic. Type: list. Required."
}

# Management VPC variables
variable "vpc_mgmt_set_default_ingress_rdp_ssh_rule" {
  type        = "string"
  default     = "true"
  description = "Boolean value to define whether or not to create the default GRACE RDP/SSH ingress rule for a security group in the management VPC. Default: true"
}

variable "vpc_mgmt_set_default_egress_rule" {
  type        = "string"
  default     = "true"
  description = "Boolean value to define whether or not to create the default GRACE egress rule for a security group in the management VPC. Default: true"
}

variable "vpc_mgmt_set_default_private_nacl" {
  type        = "string"
  default     = "true"
  description = "Boolean value to define whether or not to create the default GRACE NACL for private subnets in the management VPC. Default: true"
}

variable "vpc_mgmt_ec2_management_sg_name" {
  type        = "string"
  description = "Name for the management security group in the management VPC. Required."
}

variable "mgmt_sg_ingress_rdp_port" {
  type        = "string"
  default     = "3389"
  description = "Port for RDP traffic in the management security group in the management VPC. Default: 3389"
}

variable "mgmt_sg_ingress_rdp_protocol" {
  type        = "string"
  default     = "tcp"
  description = "Protocol for RDP traffic in the management security group in the management VPC. Default: tcp"
}

variable "mgmt_sg_ingress_rdp_cidrs" {
  type        = "list"
  description = "List of CIDR ranges to accept RDP traffic from (typically on-prem or VDI). Type: list. Required."
}

variable "mgmt_sg_ingress_ssh_port" {
  type        = "string"
  default     = "22"
  description = "SSH port for management security group in the GRACE management VPC. Default: 22"
}

variable "mgmt_sg_ingress_ssh_protocol" {
  type        = "string"
  default     = "tcp"
  description = "Protocol for SSH traffic in the management security group in the management VPC. Default: tcp"
}

variable "mgmt_sg_ingress_ssh_cidrs" {
  type        = "list"
  description = "List of CIDR ranges to accept SSH traffic from (typically on-prem or VDI). Type: list. Required."
}

variable "mgmt_private_nacl_ingress_cidrs" {
  type        = "string"
  description = "list of CIDR ranges to accept traffic from (typically on-prem or VDI). Type: list. Required."
}

variable "mgmt_private_nacl_egress_cidrs" {
  type        = "string"
  description = "List of CIDR ranges for egress traffic to (typically on-prem or VDI). Type: list. Required."
}

variable "vpc_mgmt_ec2_egress_on_prem_sg_name" {
  type        = "string"
  description = "Name of the egress security group in management VPC. Required."
}

variable "mgmt_ec2_egress_on_prem_smtp_cidrs" {
  type        = "list"
  description = "List of CIDR ranges to egress SMTP traffic to (typically on-prem mail servers). Type: list. Required."
}

variable "mgmt_ec2_egress_on_prem_all_traffic_cidrs" {
  type        = "list"
  description = "List of CIDR ranges to egress traffic for everything else (typically on-prem or VDI). Type: list. Required."
}
