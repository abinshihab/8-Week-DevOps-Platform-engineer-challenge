# Week 3 — Modular Infrastructure Composition & Autoscaling

## 🚀 Overview

In **Week 3** of the 8-Week DevOps & Platform Engineer Challenge, I focused on building a production-ready infrastructure by composing Terraform modules created in Week 2. This week was about making the system **scalable**, **highly available**, and **modular**.

### 🔑 Objectives:
- Add NAT Gateways for private subnets.
- Build an Autoscaling Group (ASG) for dynamic EC2 scaling.
- Attach Application Load Balancer (ALB) with health checks.
- Refactor Terraform modules to cleanly handle dependencies.
- Strengthen remote backend for state management.

---

## 🛠️ What I Built

### ✅ NAT Gateway Module
A reusable NAT Gateway module to enable internet access from private subnets without exposing them directly.

### ✅ Autoscaling Group Module
Provisioned an ASG with:
- Launch configuration (AMI, instance type, etc.)
- CPU-based scaling policy
- Health checks and termination policies

### ✅ Load Balancer Module
Created an ALB with:
- Listener (port 80)
- Target group for the ASG
- Health check configuration

### ✅ Modular Environment Composition
Wired together multiple modules:
- VPC
- NAT Gateway
- ASG
- ALB

Each component is reusable, parameterized, and deployable across environments.

### ✅ Remote State Backend
Used **S3** for state storage and **DynamoDB** for locking to ensure safe collaboration and consistency.

---

## 🔧 Tools & Technologies

- **Terraform** (v1.x)
- **AWS Provider** (v5.x)
- **AWS Services**: VPC, NAT Gateway, EC2, Auto Scaling, ALB
- **Remote State**: S3 + DynamoDB
- **Git** for version control

---

## ⚔️ Key Challenges & Solutions

- **Module Dependencies**: Passed outputs from one module into another cleanly to maintain separation of concerns.
- **Scaling Latency**: Learned that CPU-based scaling may react slowly; plan to explore custom CloudWatch metrics.
- **Security Groups**: Designed SGs carefully for ALB-EC2 communication without overexposing instances.
- **State Safety**: Enabled state locking to avoid concurrent modifications during `terraform apply`.

---

## ⏭️ What's Next?

- Add metrics like **memory & network I/O** to scaling policy.
- Integrate **Route 53** and **service discovery** (via ECS or Consul).
- Automate with **CI/CD** (e.g., GitHub Actions or GitLab CI).
- Experiment with **Blue/Green** and **Canary deployments**.

---

## 📌 How to Use This

1. Clone the repo.
2. Navigate to `envs/dev`.
3. Run `terraform init`.
4. Run `terraform plan`.
5. Run `terraform apply`.

---

📍 *By Ahmed Bin Shehab*  
💼 *Sr. IT Support Engineer | Cloud Architect @ Cloud Mind Company*  
🌐 *AWS | Azure | OCI Certified*
