# Week 1: Terraform Basics, GitHub Integration & CI/CD Setup

## 🎯 Goal
Kickstart the 8-Week DevOps & Platform Engineer Challenge by building foundational Terraform skills, integrating version control with Git/GitHub, and setting up a basic CI/CD pipeline using GitHub Actions.

---

## ✅ What I Accomplished

### 📌 Git & GitHub
- Initialized a Git repository and created a clean branching strategy
- Configured `.gitignore` to exclude Terraform state files and provider binaries
- Handled GitHub file size errors (>100MB) and cleaned repo history with `git filter-repo`
- Used `git push --force` carefully after filtering out unwanted files

### 📌 Terraform VPC Module
- Built a reusable Terraform module for AWS VPC
- Applied HCL best practices
- Organized code in a structured layout

### 📌 GitHub Actions CI/CD Pipeline
- Created `.github/workflows/terraform.yml`
- Configured the pipeline to run on `push` and `pull_request` to `dev`
- Steps included:
  - Checkout repo
  - Setup Terraform
  - Terraform init, validate, and plan

### 🔐 AWS Credentials in CI
- Used `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` securely via GitHub Secrets
- Set region (`us-east-1`) and working directory (`Week1/terraform-vpc-module`) explicitly

---

## 🧠 Lessons Learned
- Infrastructure as Code is powerful but needs structure
- CI/CD with Terraform helps catch issues early
- Managing state and `.terraform` folders properly is critical
- GitHub Actions + Git hygiene = effective automation

---

## 📂 Directory Structure
```
Week1/
├── terraform-vpc-module/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── .gitignore
│   └── .github/
│       └── workflows/
│           └── terraform.yml
```

---

## 🔗 Repository
[GitHub Repo – 8-Week DevOps & Platform Engineer Challenge](https://github.com/abinshihab/8-Week-DevOps-Platform-engineer-challenge)

---

## 🚀 What's Next – Week 2
- Remote backend setup using S3 + DynamoDB
- Terraform state locking
- Module versioning and reuse
- Simulating real production infrastructure layout

---

## 📅 Week 1 Summary
| Day | Focus                                     |
|-----|-------------------------------------------|
| 1   | Git, GitHub setup, repo hygiene           |
| 2   | Terraform VPC module structure            |
| 3   | Writing variables and outputs             |
| 4   | Clean state and `.terraform` folders      |
| 5   | GitHub Actions intro                      |
| 6   | AWS secrets setup for CI/CD               |
| 7   | CI pipeline working end-to-end ✅         |

---

Stay tuned for Week 2 – we go deeper into production-grade Terraform!

