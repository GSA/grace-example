# Spoke VPC module

This is a Terraform module sets up a spoke VPC for connection to a Transit VPC, following the [Cisco CSR tutorial](https://docs.aws.amazon.com/solutions/latest/cisco-based-transit-vpc/step3.html).

## Usage

Your VPC must have a route table and a VPN Gateway, with routes propagated. The VPN Gateway must have a tag of `transitvpc:spoke` with value `true`.

## Destroying

Any Terraform code that uses this module won't be able to destroy the `aws_vpn_gateway`, because the VPN connection (managed outside of Terraform) is still attached. The workaround, as noted in [the official documentation](https://docs.aws.amazon.com/solutions/latest/cisco-based-transit-vpc/components.html):

1. Open [the list of Gateways in the Console](https://console.aws.amazon.com/vpc/home#VpnGateways:sort=VpnGatewayId).
1. Change the Gateway's `transitvpc:spoke` tag Value to `to-delete`.
1. Run `terraform destroy` in your Terraform module.
