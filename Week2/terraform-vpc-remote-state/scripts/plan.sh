#!/bin/bash
ENV=$1
if [ -z "$ENV" ]; then
  echo "Usage: ./scripts/plan.sh <env>"
  exit 1
fi

terraform plan -var-file="envs/${ENV}/terraform.tfvars"
