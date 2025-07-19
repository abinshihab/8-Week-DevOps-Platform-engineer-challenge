#!/bin/bash
ENV=$1
if [ -z "$ENV" ]; then
  echo "Usage: ./scripts/apply.sh <env>"
  exit 1
fi

terraform apply -var-file="envs/${ENV}/terraform.tfvars"
