#!/bin/bash
ENV=$1
if [ -z "$ENV" ]; then
  echo "Usage: ./scripts/destroy.sh <env>"
  exit 1
fi

terraform destroy -var-file="envs/${ENV}/terraform.tfvars"
