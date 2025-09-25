# Terraform CI/CD Bootstrap

## Structure
- **bootstrap-backend/** → Create S3 + DynamoDB for Terraform state.
- **ci-cd/** → Jenkins and GitHub Actions pipelines.
- **envs/** → Environment variable files (dev/stage/prod).
- **scripts/** → Helper scripts for local/manual runs.

## Usage
1. Run `bootstrap-backend` once to create the Terraform backend.
2. Use `scripts/init.sh` to initialize Terraform.
3. Use `scripts/apply.sh dev` to apply Terraform for a given environment.
4. CI/CD pipelines automatically pick up `envs/*.tfvars` for deployments.
