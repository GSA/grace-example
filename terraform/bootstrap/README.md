# GRACE Example Bootstrap Procedure

This directory contains the terraform code to bootstrap the environment
for CI/CD with Terraform, GitHub, and CircleCI.

## Prerequisites

1. You will need tenant accounts in the GRACE environment.
1. You will need to have terraform, make, git and openssl installed on your
 workstation
1. You will need to fork this repository
1. You will need to have AWS credentials configured that can assume FullAdmin
access to your tenant accounts in your `~/.aws/credentials` file.

## Step-by-Step Instructions

1. Set your environment

    ```
    export KEY=<secret_key_for_AES_encryption>
    export AWS_DEFAULT_REGION=us-east-1
    export TF_VAR_env_account_id=111111111111
    export TF_VAR_mgmt_account_id=222222222222
    ```

1. Run the bootstrap commands via `make`

    ```
    make bootstrap
    ```

1. Commit the configuration to source control. (Note: If you cannot commit
  directly to master, you may have to create a feature branch)

    ```
    git add .
    git commit -m "Bootstrapped environment for CircleCI"
    git push origin master
    ```

1. Configure CircleCI.  You will need to set the `KEY`
[environment variable](https://circleci.com/docs/2.0/env-vars/#adding-environment-variables-in-the-app)
in CircleCI to the same value you used when you ran `make bootstrap`

## Workaround for CloudFormation Stack

The Cloud Formation Transit-Spoke-Stack creates an IAM role.  This requires
Administrator access and the CircleCI deployer only has PowerUser access.  One
possible workaround is to do the initial deployment locally and then use
CircleCI for changes that do not require Administrator access.

```
export KEY=<secret_key_for_AES_encryption>
openssl aes-256-cbc -d -in terraform/bootstrap/secret-env-cipher -out terraform/bootstrap/secret-env-plain -k $KEY
source terraform/bootstrap/secret-env-plain
unset AWS_SECRET_ACCESS_KEY && unset AWS_ACCESS_KEY
sed -i .bak 's/PowerUser/Administrator/g' terraform/bootstrap/deployer_*.tf
rm terraform/bootstrap/*.bak
make bootstrap
source terraform/bootstrap/secret-env-plain
make deploy
git checkout terraform/bootstrap/deployer_*.tf
unset AWS_SECRET_ACCESS_KEY && unset AWS_ACCESS_KEY
make bootstrap
git add .
git commit -m "Updating CircleCI deployer credentials"
git push origin master
```
