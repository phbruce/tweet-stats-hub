.PHONY: fmt-check init plan apply

fmt-check:
	cd terraform/$(TERRAFORM_MODULE) && \
	if ! terraform fmt -check; then \
	  echo "Terraform format check failed. Run 'terraform fmt' to fix the format."; \
	  exit 1; \
	fi

init: cls
	cd terraform/$(TERRAFORM_MODULE) && \
	terraform init -backend-config=$(ENV_DIR)/backend.conf

plan:
	cd terraform/$(TERRAFORM_MODULE) && \
	terraform plan -var-file=$(ENV_DIR)/variables.tfvars

apply:
	cd terraform/$(TERRAFORM_MODULE) && \
	terraform apply -auto-approve -var-file=$(ENV_DIR)/variables.tfvars

destroy:
	cd terraform/$(TERRAFORM_MODULE) && \
	terraform destroy -auto-approve -var-file=$(ENV_DIR)/variables.tfvars

cls:
	cd terraform/$(TERRAFORM_MODULE) && \
	rm -rf .terraform terraform.tfstate.d/ .terraform.lock.hcl terraform.tfstate terraform.tfstate.backup
