#!/bin/bash
set -e

# ----------------------------
# Terraform Plan Script
# ----------------------------
# Usage: ./plan.sh [environment]
# Example: ./plan.sh dev
# ----------------------------

# Get environment argument (defaults to dev)
ENV=${1:-dev}
TFVARS_FILE="envs/${ENV}/${ENV}.tfvars"

echo "🧩 Running Terraform plan for environment: ${ENV}"

# Navigate to Terraform root (one level up if inside /Script folder)
cd "$(dirname "$0")/.."

# Initialize Terraform (safe to re-run)
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

# Check if sensitive variables exist in environment
if [[ -z "${ALLOWED_SSH_CIDR}" || -z "${MY_TRUSTED_IP}" ]]; then
  echo "⚠️  Warning: Environment variables ALLOWED_SSH_CIDR or MY_TRUSTED_IP not set."
  echo "💡 Set them before running:"
  echo "   export ALLOWED_SSH_CIDR=\"x.x.x.x/32\""
  echo "   export MY_TRUSTED_IP=\"x.x.x.x/32\""
fi

# Terraform plan with secure variable injection
PLAN_OUT="tfplan-${ENV}.out"
echo "📋 Generating Terraform plan..."
terraform plan \
  -input=false \
  -var-file="${TFVARS_FILE}" \
  -var="allowed_ssh_cidr=${ALLOWED_SSH_CIDR}" \
  -var="my_trusted_ip=${MY_TRUSTED_IP}" \
  -out="${PLAN_OUT}"

# Save a human-readable version of the plan
terraform show -no-color "${PLAN_OUT}" > "tfplan-${ENV}.txt"

echo "✅ Plan generated successfully → tfplan-${ENV}.out and tfplan-${ENV}.txt"
