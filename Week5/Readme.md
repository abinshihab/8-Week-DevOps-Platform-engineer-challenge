# 🚀 Week 5 – DevOps & Platform Engineer Challenge

**Theme:** Observability, Security & CI/CD Integration

Week 5 focuses on taking the production-ready infrastructure from Week 4 and **making it fully observable, secure, and automated**. The goal is to prepare your cloud stack for multi-environment deployments with monitoring, logging, alerts, and CI/CD pipelines.

---

## 📅 Daily Breakdown

**Day 29 – Observability Basics:**  
- Designed CloudWatch dashboards for EC2, ASG, and ALB metrics.  
- Configured alarms for CPU, memory, and request latency.  
✅ Early visibility into performance and scaling events.  

**Day 30 – Logging & Centralized Metrics:**  
- Enabled CloudWatch logs for application instances and ALB access logs.  
- Aggregated logs using CloudWatch Log Groups.  
✅ Simplified troubleshooting and auditing.  

**Day 31 – IAM Roles & Security Hardening:**  
- Created IAM roles for EC2, ALB, and Lambda with least-privilege access.  
- Reviewed security group rules for VPC, ALB, and compute instances.  
✅ Infrastructure secured following AWS best practices.  

**Day 32 – CI/CD Integration Setup:**  
- Configured CodePipeline/CodeBuild (or GitHub Actions) for automated Terraform deployment.  
- Added pre-deployment checks: plan validation, linting, and module testing.  
✅ Infrastructure can now be deployed consistently with minimal human intervention.  

**Day 33 – Multi-Environment Strategy:**  
- Introduced dev/stage/prod environment folders.  
- Parameterized modules with workspace variables.  
✅ Easily replicate infrastructure across multiple stages.  

**Day 34 – Monitoring Enhancements & Notifications:**  
- Configured CloudWatch SNS topics for alerting.  
- Integrated Slack/email notifications for scaling events or alarms.  
✅ Real-time notifications for rapid response.  

**Day 35 – Week 5 Wrap-Up & Documentation:**  
- Updated README and architecture diagrams.  
- Captured all outputs, IAM role ARNs, dashboards, and pipeline links.  
- Prepared notes for Week 6: advanced automation, Lambda integration, and event-driven workflows.  
✅ Week 5 complete: fully observable, secure, and automated infrastructure ready for production-ready multi-environment deployments.

---

## 🛠️ Key Modules

- **VPC Module** – Networking foundation.  
- **Compute Module** – Hybrid EC2 or ASG.  
- **ALB Module** – Load balancing & health checks.  
- **Scaling Policies** – Elastic compute behavior.  
- **Monitoring Module** – CloudWatch dashboards & alarms.  
- **Logging Module** – Centralized logs & access control.  
- **Security Module** – IAM roles & least-privilege policies.  
- **CI/CD Pipelines** – Automated Terraform deployment.

---

## 🌟 Highlights of Week 5

- Implemented full **observability** for compute, load balancer, and auto-scaling events.  
- Hardened **security** using IAM roles and least-privilege practices.  
- Automated deployments with **CI/CD pipelines** for repeatable and safe updates.  
- Parameterized infrastructure for **multi-environment support** (dev/stage/prod).

---

## 📖 Learnings

- Observability is crucial before scaling workloads further.  
- Logging + alerts = faster incident response & easier troubleshooting.  
- Security must be integrated early in IaC pipelines, not retrofitted.  
- CI/CD pipelines reduce human error and speed up deployment cycles.  
- Multi-environment strategies ensure consistent infrastructure and reduce drift.

---

## 📌 Next Steps (Week 6 Preview)

- Integrate **event-driven architecture** using Lambda & SNS/SQS.  
- Explore **serverless infrastructure automation**.  
- Optimize **cost & performance** with metrics-driven decisions.  
- Extend Terraform modules to handle **dynamic policies & blue/green deployments**.

---

## 🔖 Tags

#DevOps #Terraform #AWS #PlatformEngineering #CloudInfrastructure #Observability #CI/CD #Security
