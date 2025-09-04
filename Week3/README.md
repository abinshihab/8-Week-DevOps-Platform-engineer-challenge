# Week 3 — Modular Infrastructure Composition & Autoscaling

**Theme:** *Composing Terraform Modules for Scalable and Highly Available Infrastructure*

Week 3 focused on **turning individual modules from Week 2 into a unified, production-ready stack**. The goal was modularity, scalability, and high availability.

---

## 📅 Daily Breakdown

### **Day 15**
- Refactored **compute module** to support both EC2 and ASG modes via `compute_mode` toggle.
- Added flexible variables for instance type, AMI, and subnet selection.
- ✅ Prepared modules for easy composition with other services.

---

### **Day 16**
- Built **NAT Gateway module** for private subnet internet access.
- Configured module for multiple availability zones.
- ✅ Validated routing and connectivity from private subnets.

---

### **Day 17**
- Created **ASG module**:
  - Launch configuration (AMI, instance type, key pair)
  - CPU-based scaling policy
  - Health checks and termination policies
- ✅ Tested ASG deployment and instance registration.

---

### **Day 18**
- Developed **ALB module**:
  - HTTP listener (port 80)
  - Target Group for ASG instances
  - Health check configuration
- ✅ Validated ALB independently with test instances.

---

### **Day 19**
- **Integrated all modules**:
  - VPC → NAT → ASG → ALB
  - Passed outputs/inputs between modules cleanly
  - Verified instance registration and traffic flow
- ✅ End-to-end infrastructure working.

---

### **Day 20**
- Configured **remote backend**:
  - S3 bucket for Terraform state
  - DynamoDB table for state locking
- ✅ Applied modules using remote backend successfully.

---

### **Day 21**
- **Final validation & documentation**:
  - Stress-tested ASG + ALB combination
  - Verified scaling triggers and health check replacements
  - Documented all module outputs for future reuse
- ✅ Week 3 complete: modular, scalable, production-ready infrastructure.

---

## 🛠️ Key Modules

- **VPC Module** – Networking foundation
- **NAT Gateway Module** – Internet access for private subnets
- **Compute/ASG Module** – Dynamic EC2 scaling
- **ALB Module** – Load balancing & health checks

---

## 🌟 Highlights of Week 3

- Composed multiple modules into a unified, reusable stack.
- Implemented ASG with scaling policies and health checks.
- Configured ALB integration with auto-registered instances.
- Remote backend enabled safe, collaborative Terraform deployments.

---

## 📖 Learnings

- Outputs are critical for **module integration**.
- Scaling policies and health checks ensure **resilience**.
- Remote state improves **team collaboration** and consistency.
- Modular design allows **future expansion** in Week 4.

---

## ⏭️ Next Steps (Week 4 Preview)

- Integrate **ALB + ASG fully** for load balancing and scaling.
- Conduct **stress testing** to validate performance under load.
- Refactor module outputs for **consistent naming and reusability**.
- Prepare for **Week 4: production-grade scaling and high availability**.

---

📍 *By Ahmed Bin Shehab*  
💼 *Sr. IT Support Engineer | Cloud Architect @ Cloud Mind Company*  
🌐 *AWS | Azure | OCI Certified*
