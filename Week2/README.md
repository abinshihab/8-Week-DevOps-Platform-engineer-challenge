# 📦 Week 2 – Terraform State, Remote Backends & Module Reuse  
**8-Week DevOps & Platform Engineer Challenge by [@abinshihab](https://github.com/abinshihab)**

---

## 🚀 Goals for Week 2
- ✅ Understand how Terraform stores and tracks infrastructure state
- ✅ Explore and modify the `terraform.tfstate` file (locally and remotely)
- ✅ Migrate state from local to remote backend (S3 + DynamoDB)
- ✅ Learn how to lock Terraform state to avoid race conditions
- ✅ Reuse Terraform modules with versioning for better infrastructure management

---

## 📁 Folder Structure
```
Week2/
├── local-state-demo/
│   ├── main.tf
│   ├── terraform.tfstate
│   └── README.md
├── remote-state-backend/
│   ├── backend.tf
│   ├── main.tf
│   └── README.md
├── terraform-vpc-remote-state/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── backend.tf     # optional, if backend config is separate
└── modules/
    └── vpc/
        ├── main.tf
        ├── outputs.tf
        ├── variables.tf
        └── README.md   # optional, but good practice

```

---

## 📍 What I will Learn

### 🧠 Terraform State (Day 8–9)
- What is `terraform.tfstate`?
- Why is it important?
- How Terraform compares state to your code and actual infrastructure

### 🔍 Inspecting the `.tfstate` File
- Use `jq` or open the file in a text editor
- Identify resource blocks and stored attributes
- Understand how changes are reflected in state

---

## ☁️ Remote State with S3 + DynamoDB (Day 10–11)
- Move your local state to **AWS S3** for team collaboration
- Use **DynamoDB** table for state locking to avoid parallel updates
- Protect production state files with versioning and encryption

```hcl
# backend.tf
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "envs/prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

---

## 📦 Module Reuse & Versioning (Day 12–13)
- Split large Terraform projects into modules
- Use `source = "../modules/vpc"` or GitHub repos
- Apply version control on modules using Git tags or Terraform Registry

```hcl
module "vpc" {
  source = "../modules/vpc"
  cidr_block = "10.0.0.0/16"
}
```

---

## ✅ Bonus Exercises (Day 14 Review)
- Migrate existing state to remote backend
- Lock and unlock state intentionally to test concurrency
- Version your module with Git tags (`v1.0.0`) and use from GitHub

---

## 🔐 Secrets and Best Practices
- Never commit `terraform.tfstate` or `.terraform/` folders
- Always use `.gitignore` to protect secrets
- Use S3 bucket policies and encryption for backend security

---

## 📌 Repo Structure Suggestion

You can keep Week 2 inside your existing repo like:

```
8-Week-DevOps-Platform-engineer-challenge/
├── Week1/
├── Week2/
│   ├── README.md ✅
│   ├── local-state-demo/
│   ├── remote-state-backend/
│   └── modules/
```

---

## 🧠 Learn More
- [Terraform State Docs](https://developer.hashicorp.com/terraform/language/state)
- [Terraform Backend Docs](https://developer.hashicorp.com/terraform/language/settings/backends/s3)
- [Module Registry Docs](https://developer.hashicorp.com/terraform/language/modules/sources)
