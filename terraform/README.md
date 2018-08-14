# GRACE Example - terraform

## Bootstrap

Contains the terraform configuration to bootstrap this example in a GRACE tenant
account.

1. *fork the repository*
Since CircleCI will deploy to your environment, you will need to fork this
repository to set the CircleCI environment to deploy to your tenant accounts.

1. Ensure you have AWS credentials configured that can assume roles in the mgmt and
env accounts with sufficient privileges to create IAM users and roles.

1. Set the following environment variables

    ```
    export AWS_DEFAULT_REGION=us-east-1
    export TF_VAR_mgmt_account_id=111111111111
    export TF_VAR_env_account_id=111111111111
    ```

1. Bootstrap the repository with CircleCI IAM user for CirceCI deployer with
access key and secret key and S3 bucket for backend

   ```
   make bootstrap
   ```

## Networking

Contains the terraform configuration for a mgmt vpc and an env vpc each with
two public and two private subnets and ssh jumphosts.

### ssh jumphost

This directory contains terraform code to create a HA jumphost in the public
subnet of your mgmt and env accounts.  The jumphosts are created from an AMI
created with the `packer/jumpbox.json` packer template and configured with the
Ansible playbook `ansible/jumphost.yml`.

##### High Availability

There are a minimum of two jumphosts spread accross multiple availability zones.  The hosts are created dynamically as part of an [Amazon EC2 Auto Scaling Group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/AutoScalingGroup.html).
The AMIs for the auto scaling group are created via packer and ansible from a hardened AMI.

#### AMI Launch Permissions

The AMI is created only in the mgmt account and is shared with
the env account.  If you want to have different user configuration in each
account you can modify the code to create an AMI in each account instead.

#### User Management

The user ids and roles and public keys are created by the `ansible/jumphost.yml` Ansible playbook.  User public keys are also stored in the `ansible/keys` directory.  More sophisticated user management is TBD.