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

## 🌍 2. Initialize Terraform
Run this in your environment directory:
```bash
./scripts/init.sh
```
## 🚀 3. Apply Infrastructure
Deploy infrastructure for a specific environment:
```bash
./scripts/apply.sh dev

```
Other environments:
```bash
./scripts/apply.sh stage
./scripts/apply.sh prod
```
## 🧩 4. CI/CD Integration
Jenkins and GitHub Actions pipelines automatically:

Initialize Terraform

Run plan and apply using environment parameters
Fetch secure variables from **AWS SSM Parameter Store**
No secrets or IPs are hardcoded — everything is fetched securely during runtime.

## 🔒 Security Best Practices
Sensitive variables (like passwords and CIDRs) are stored in **AWS Systems Manager Parameter Store**:

**Store:**
```bash
/cloudmind/dev/db_password
/cloudmind/dev/allowed_ssh_cidr
/cloudmind/dev/my_trusted_ip

```
- These are accessed securely using:
``` bash
data "aws_ssm_parameter" "db_password" {
  name            = "/cloudmind/dev/db_password"
  with_decryption = true }

```
- .tfvars files only contain non-sensitive data such as:
```bash 
aws_region  = "us-east-1"
environment = "dev"
instance_type = "t3.micro"

```

## 🧠 CI/CD Highlights

- **Parameterized Jenkins Pipeline** for multi-environment deployment.
- **Secure Variable Injection** from AWS SSM.
- **Rollback Stage** for controlled infrastructure changes.
- **Slack Notifications** for build status (optional).

## 🪄 Example Jenkins Parameter

```bash 
parameters {
  choice(name: 'ENV', choices: ['dev', 'stage', 'prod'], description: 'Select environment')}

```
