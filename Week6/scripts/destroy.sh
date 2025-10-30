#!/bin/bash
ENV=${1:-dev}
echo "Destroying Terraform for environment: $ENV"
terraform destroy -auto-approve -var-file="envs/${ENV}.tfvars"
