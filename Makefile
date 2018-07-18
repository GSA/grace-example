default: validate

validate:
	cd terraform/bootstrap && \
	  terraform init && \
	  terraform validate
	cd terraform/master && \
	  terraform init -backend-config=bucket=$(TF_ENV_BUCKET) && \
	  terraform validate && \
		terraform plan

bootstrap:
	cd terraform/bootstrap && \
	  terraform init && \
		terraform apply -input=false -auto-approve  && \
		echo "export TF_ENV_BUCKET=$(shell cd terraform/bootstrap && terraform output bucket)" > secret-env-plain; \
		echo "export AWS_ACCESS_KEY=$(shell cd terraform/bootstrap && terraform output access_key)" >> secret-env-plain; \
		echo "export AWS_SECRET_ACCESS_KEY=$(shell cd terraform/bootstrap && terraform output secret)" >> secret-env-plain; \
		echo "export AWS_DEFAULT_REGION=$(AWS_DEFAULT_REGION)" >> secret-env-plain; \
		echo "export TF_VAR_env_acct_id=$(TF_VAR_env_acct_id)" >> secret-env-plain; \
		openssl aes-256-cbc -e -in secret-env-plain -out secret-env-cipher -k $(KEY)

deploy:
	cd terraform/master && \
	  terraform init -backend-config=bucket=$(TF_ENV_BUCKET) && \
		terraform apply -input=false -auto-approve
