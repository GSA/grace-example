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
