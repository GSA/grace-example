## GRACE jumphost

This directory contains terraform code to create a HA jumphost in the public
subnet of your mgmt and env accounts.  The jumphosts are created from an AMI
created with the `packer/jumpbox.json` packer template and configured with the
Ansible playbook `ansible/jumphost.yml`.

### Design Conderations

#### High Availability

There are a minimum of two jumphosts behind an AWS classic load balancer.
The hosts are spread accross multiple availability zones.  The hosts are created
dynamically as part of an [Amazon EC2 Auto Scaling Group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/AutoScalingGroup.html).
The AMIs for the auto scaling group are created via packer and ansible.

#### AMI Launch Permissions

For the example, the AMI is created only in the mgmt account and is shared with
the env account.  If you want to have different user configuration in each
account you can modify the code to create an AMI in each account instead.

#### SSH Host Key Management

The hosts in each account share a common host key which is stored in an [Amazon EC2 Systems
Manager Parameter Store](https://aws.amazon.com/ec2/systems-manager/parameter-store/)

#### User Management

The user ids, roles and public keys are also stored in <TBD>
