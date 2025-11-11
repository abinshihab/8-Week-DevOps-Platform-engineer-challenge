# Week 7 – Observability & Monitoring 📊  
**8-Week Cloud & DevOps Challenge – Ahmed Bin Shehab**

---

### 🎯 Objective
Week 7 transforms the infrastructure from “automated” to “observable.”  
The goal is to build a complete **monitoring and alerting layer** for all environments (dev / stage / prod) using AWS CloudWatch, SNS, and CI/CD integration.

By the end of this week, the cloud will:
- Expose **real-time performance dashboards** (EC2 CPU, Network, ALB traffic, latency).
- Trigger **alarms + notifications** via SNS + Slack when thresholds are breached.
- Enable **multi-environment visibility** with isolated Terraform remote states.
- Lay the foundation for **AI-driven Cloud Ops** (Week 8).

---

### 🧩 Architecture Overview
| Layer | Purpose |
|-------|----------|
| **CloudWatch Dashboards** | Visualize EC2, ALB, ASG metrics per environment |
| **CloudWatch Alarms** | Detect high CPU, unhealthy targets, traffic spikes |
| **SNS Topic + Email/Slack** | Alerting channel for admins & pipelines |
| **IAM Role for CW Agent** | Grants EC2 instances permission to push metrics |
| **CI/CD Integration** | Jenkins + GitHub Actions automatically deploy the monitoring stack |

---

### 📁 Folder Structure
Week7/
├── monitoring/
│   ├── main.tf                   # Calls the cloudwatch-alerts module
│   ├── variables.tf              # Env + thresholds + email
│   ├── outputs.tf                # Exposes SNS ARN & alarm names
│   ├── envs/
│   │   ├── dev/
│   │   │   ├── backend.conf
│   │   │   └── dev.tfvars
│   │   ├── stage/
│   │   │   ├── backend.conf
│   │   │   └── stage.tfvars
│   │   └── prod/
│   │       ├── backend.conf
│   │       └── prod.tfvars
│   └── ci-cd/
│       ├── Jenkinsfile            # Terraform pipeline w/ rollback + promotion
│       └── github-actions/
│           └── terraform.yml      # GitHub Actions CI/CD workflow
└── modules/
    └── cloudwatch-alerts/         # Reusable CloudWatch + SNS + IAM logic


---

### ⚙️ How to Deploy

#### 🔹 Using Terraform CLI (quick test)
```bash
cd Week7/monitoring
terraform init -backend-config=envs/dev/backend.conf
terraform plan  -var-file=envs/dev/dev.tfvars
terraform apply -auto-approve -var-file=envs/dev/dev.tfvars
```
### 🔹 Using Jenkins Pipeline

**Job path:** `Week7/monitoring/ci-cd/Jenkinsfile`  

**Parameters:**
- `TARGET_ENV` → dev / stage / prod  
- `APPLY_INFRA` ✅  
- `ROLLBACK_ON_FAILURE` ✅  

The pipeline auto-promotes **dev → stage → prod**, with manual approval for production.

---

### 🔹 Using GitHub Actions

**Workflow:** `Week7/monitoring/ci-cd/github-actions/terraform.yml`  

**Trigger:** Manually (“Run workflow”) or on push to `main`.  

**Required Secrets:**
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`
- `SLACK_WEBHOOK_URL`

---

### 📊 Outputs

| Output | Description |
|--------|--------------|
| `sns_topic_arn` | SNS topic used for CloudWatch alerts |
| `asg_cpu_alarm_name` | Name of Auto-Scaling CPU alarm |
| `alb_unhealthy_alarm_name` | Name of ALB unhealthy-target alarm |
| `dashboard_name` | CloudWatch dashboard identifier |

---

### 🧠 Next Step → Week 8

Connect the monitoring pipeline to an **AI-Driven Lambda Agent** that:
- Analyzes CloudWatch metrics and usage patterns  
- Predicts anomalies or performance degradation  
- Triggers scaling actions autonomously  

This marks the evolution from **monitoring → intelligence → self-healing cloud**.
