variable "vpc_id" {
  type = "string"
}

variable "TransitVpcBucketName" {
  default = "grace-transit-vpc-cisco-csr-vpnconfigs3bucket-8qip7j4p30dd"
}

variable "TransitVpcBucketPrefix" {
  default = "vpnconfigs/"
}
