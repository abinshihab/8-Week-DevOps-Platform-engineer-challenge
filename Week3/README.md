# Week 3 — Modular Infrastructure Composition & Autoscaling

## Overview

In Week 3 of the 8-Week DevOps & Platform Engineer Challenge, the focus was on advancing the modular infrastructure built in Week 2 by composing multiple Terraform modules to create a scalable and highly available environment.

Key goals included:

- Integrating NAT Gateways for secure internet access in private subnets  
- Building Autoscaling Groups to enable dynamic scaling of EC2 instances  
- Configuring Load Balancers (ALB) for traffic distribution  
- Managing dependencies between modules for reusable infrastructure  
- Enhancing Terraform state management for collaboration and remote execution  

---

## What I Built

- **NAT Gateway Module:** Developed a reusable module to deploy NAT Gateways across multiple Availability Zones, enabling private subnets to securely access the internet without exposure.  
- **Autoscaling Group Module:** Created an ASG with launch configurations, health checks, and CPU-based scaling policies for automatic scaling of EC2 instances.  
- **Load Balancer Module:** Configured an Application Load Balancer (ALB) with listeners and target groups to route incoming traffic to the autoscaled instances.  
- **Environment Composition:** Combined VPC, NAT Gateway, Autoscaling Group, and Load Balancer modules into a cohesive, modular environment stack, promoting maintainability and scalability.  
- **Terraform Backend:** Continued using S3 and DynamoDB backend for remote state storage and state locking to avoid conflicts during collaboration.  

---

## Technologies & Tools

- Terraform (version X.Y.Z)  
- AWS Provider (version X.Y)  
- AWS Services: VPC, NAT Gateway, EC2, Auto Scaling, Application Load Balancer (ALB)  
- Remote State Management: S3 + DynamoDB  
- Git for version control  

---

## Key Challenges & Solutions

- **Managing Module Dependencies:** Utilized Terraform outputs and input variables effectively to wire modules together without hardcoding resource IDs, maintaining modularity.  
- **Scaling Policies:** Implemented CPU utilization-based scaling; noticed latency in scaling actions, which highlighted the need to explore custom CloudWatch alarms for more responsive scaling.  
- **State Management:** Configured remote backend with locking to prevent state corruption during concurrent runs, which is essential for team environments.  
- **Security Configurations:** Carefully designed security groups to allow communication between ALB and EC2 instances while keeping the network secure.  

---

## Next Steps

- Implement more granular scaling policies using additional metrics (memory, network IO).  
- Integrate DNS and service discovery for dynamic service registration.  
- Automate infrastructure deployment using CI/CD pipelines.  
- Explore deployment strategies like blue-green or canary deployments for zero downtime updates.  

---

## How to Use This Code

1. Clone the repository.  
2. Navigate to the appropriate environment folder (e.g., `environments/dev`).  
3. Run `terraform init` to initialize modules and backend configuration.  
4. Run `terraform plan` to review planned infrastructure changes.  
5. Run `terraform apply` to deploy the infrastructure.  

---

*Prepared by Ahmed Bin Shehab*  
*Senior IT Support Engineer & Cloud Solution Architect*  
*Cloud Mind Company*  
