#!/bin/bash
set -e


# Apply the plan
terraform destroy -var-file="envs/dev/dev.tfvars" -auto-approve
