# 🚀 Week 4 – DevOps & Platform Engineer Challenge

**Theme:** *Scaling & Load Balancing with Terraform (Compute + ALB + ASG + Scaling Policies)*

Week 4 was all about **moving from static infrastructure to elastic, production-ready infrastructure**. I designed Terraform modules that combine **EC2, Auto Scaling Groups (ASG), and Application Load Balancers (ALB)** to handle real-world scaling scenarios.

---

## 📅 Daily Breakdown

### **Day 22**
- Enhanced the **Compute Module**:  
  - Added support for **EC2** *or* **ASG** mode via `compute_mode` toggle.  
  - Improved outputs to make integration easier (instance IDs, ASG names, security groups).  
- ✅ This gave flexibility to deploy either single servers or scalable groups.

---

### **Day 23**
- Created the **ALB Module**:  
  - Built an **Application Load Balancer**.  
  - Added **Target Group** with health checks.  
  - Configured **Listeners** for HTTP traffic.  
- ✅ Outputs: `alb_dns_name`, `target_group_arn`, `listener_arn`.  
- Tested ALB in isolation — confirmed DNS endpoint is working.

---

### **Day 24**
- Integrated **ALB with the ASG**:  
  - Registered ASG instances to the Target Group automatically.  
  - Health checks configured for rolling replacements.  
  - Full traffic flow validated:  
    **Client → ALB → Target Group → ASG Instances → App**.  
- ✅ Achieved high availability across multiple AZs.

---

### **Day 25**
- Implemented **Scaling Policies** for the ASG:  
  - Scale-out when CPU > 70% for 2 consecutive periods.  
  - Scale-in when CPU < 30% for 5 consecutive periods.  
  - Configured **CloudWatch alarms** to trigger scaling.  
- ✅ Infrastructure now responds automatically to changing load.

---

### **Day 26**
- Conducted **Stress Testing & Validation**:  
  - Used Apache Benchmark (`ab`) to simulate 1000+ requests.  
  - Verified ALB distributed load evenly.  
  - Observed scaling events in **CloudWatch** (scale-out triggered).  
  - Monitored new instances attaching to ALB Target Group automatically.  
- ✅ Confirmed real-world readiness of the stack.

---

### **Day 27**
- **Refined Terraform Modules and Outputs**:  
  - Cleaned up `outputs.tf` across VPC, ALB, and Compute modules.  
  - Ensured naming consistency for easier integration with future modules.  
  - Tested `terraform plan` and `apply` to confirm all references work correctly.  
- ✅ Modules are now **modular, reusable, and less error-prone**.

---

### **Day 28**
- **Final Week 4 Wrap-Up & Documentation**:  
  - Documented infrastructure with diagrams and README updates.  
  - Captured all outputs: ALB DNS, Target Group ARN, ASG info.  
  - Prepared notes for Week 5: monitoring, observability, and CI/CD integration.  
- ✅ Week 4 complete: fully **elastic, high-availability infrastructure** ready for production scenarios.

---

## 🛠️ Key Modules

- **VPC Module** – Networking foundation.  
- **Compute Module** – Hybrid (EC2 or ASG).  
- **ALB Module** – Load balancing & health checks.  
- **Scaling Policies** – Elastic compute behavior.

---

## 🌟 Highlights of Week 4

- Built **production-grade modules** for Compute + ALB.  
- Achieved **elastic scaling** with ASG policies.  
- Validated system with **stress testing & CloudWatch alarms**.  
- Reinforced **outputs as contracts** between Terraform modules.

---

## 📖 Learnings

- **Outputs** are the glue for multi-module projects.  
- **ASG + ALB** is the AWS backbone for high availability.  
- **Health checks + scaling policies** ensure resilience without manual ops.  
- Stress testing is essential to prove infrastructure works under pressure.  
- Consistent module outputs reduce errors when wiring multiple services.

---

## 📌 Next Steps (Week 5 Preview)

- Add **observability**: CloudWatch dashboards, alarms, logging.  
- Introduce **IAM roles & permissions** for least-privilege security.  
- Automate deployments with **CI/CD pipelines**.  
- Expand into **multi-environment deployments** (dev/stage/prod).

---

## 🔖 Tags

`#DevOps` `#Terraform` `#AWS` `#PlatformEngineering` `#CloudInfrastructure`
