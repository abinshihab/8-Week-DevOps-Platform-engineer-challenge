#!/bin/bash
set -e

# Initialize Terraform (downloads providers)
terraform init

# Optional: show plan
terraform plan -var-file="envs/dev/dev.tfvars"

# Apply the plan
terraform apply -var-file="envs/dev/dev.tfvars" -auto-approve
