#!/bin/bash
set -e

# ----------------------------
# Terraform Apply Script
# ----------------------------
# Usage: ./apply.sh [environment]
# Example: ./apply.sh dev
# ----------------------------

# Get environment argument
ENV=${1:-dev}
TFVARS_FILE="envs/${ENV}/${ENV}.tfvars"

echo "🌍 Applying Terraform for environment: ${ENV}"

# Navigate to Terraform root (one level up if inside /Script folder)
cd "$(dirname "$0")/.."

# Initialize Terraform (safe even if already initialized)
echo "🧱 Initializing Terraform..."
terraform init -input=false

# Check if tfvars file exists
if [ ! -f "${TFVARS_FILE}" ]; then
  echo "⚠️  Warning: Variables file '${TFVARS_FILE}' not found."
  echo "Creating a placeholder one for you..."
  mkdir -p "envs/${ENV}"
  cat <<EOF > "${TFVARS_FILE}"
aws_region   = "us-east-1"
environment  = "${ENV}"
instance_type = "t3.micro"
EOF
  echo "✅ Created default ${TFVARS_FILE}"
fi

# Terraform plan
echo "🧩 Running terraform plan..."
terraform plan -var-file="${TFVARS_FILE}" -out="tfplan-${ENV}.out"

# Terraform apply
echo "🚀 Applying changes for ${ENV}..."
terraform apply -auto-approve "tfplan-${ENV}.out"

echo "✅ Terraform apply completed successfully for environment: ${ENV}"
