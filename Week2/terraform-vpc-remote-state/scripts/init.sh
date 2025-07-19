#!/bin/bash
ENV=$1
if [ -z "$ENV" ]; then
  echo "Usage: ./scripts/init.sh <env>"
  exit 1
fi

terraform init -backend-config="key=vpc/${ENV}/terraform.tfstate"
