#!/bin/bash
ENV=${1:-dev}
echo "Applying Terraform for environment: $ENV"
terraform apply -auto-approve -var-file="envs/${ENV}.tfvars"
