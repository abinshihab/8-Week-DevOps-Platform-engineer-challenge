#!/bin/bash
echo "Initializing Terraform..."
terraform init -backend-config="bucket=$TF_BUCKET" \
               -backend-config="dynamodb_table=$TF_DYNAMODB" \
               -backend-config="region=$AWS_REGION"
