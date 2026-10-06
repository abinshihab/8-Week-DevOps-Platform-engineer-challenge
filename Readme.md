# AWS Platform Infrastructure with Terraform

## Overview

This project demonstrates a modular, production-oriented AWS infrastructure architecture built with Terraform.

It focuses on designing reusable, scalable, and maintainable infrastructure across AWS networking, compute, load balancing, monitoring, security, and multi-environment configuration.

The architecture demonstrates practical infrastructure engineering patterns for reliability, security, observability, automation, and operational maintainability.

### Key Capabilities

- Multi-AZ AWS networking with public and private subnets
- Reusable and modular Terraform architecture
- EC2 and Auto Scaling Group deployment patterns
- Application Load Balancer (ALB) with health checks
- CloudWatch monitoring and alarms
- Bastion host for controlled administrative access
- Security controls using IAM and Security Groups
- Environment-based configuration for dev, stage, and prod
- Infrastructure documentation and architecture diagrams

---

## Architecture Diagram

![AWS Platform Infrastructure Architecture](images/ًِDiagram.png)

The architecture represents a multi-tier AWS environment designed with availability, scalability, security, and operational visibility in mind.

---

## Project Structure

```text
Week1/Week2/.../Week8/
│
├── main.tf                    # Root Terraform configuration
├── variables.tf               # Root variables
├── outputs.tf                 # Root outputs
├── modules/                   # Reusable Terraform modules
│   ├── vpc/
│   ├── compute-hybrid/
│   ├── alb/
│   ├── bastion_host/
│   ├── cloudwatch-alerts/
│   └── security/
├── envs/                      # Environment-specific configuration
│   ├── dev/
│   ├── stage/
│   └── prod/
├── scripts/                   # User data and setup scripts
└── README.md
```

---

## Infrastructure Components

### Networking

The networking layer provides the foundation for the AWS environment.

Key components include:

- Multi-AZ VPC architecture
- Public and private subnets
- Internet Gateway
- NAT Gateway
- Route tables
- Security Groups
- Modular Terraform networking components

### Compute

The compute layer supports different deployment patterns depending on workload requirements.

Key capabilities include:

- Amazon EC2 instances
- Launch Templates
- Auto Scaling Groups
- EC2 and ASG deployment modes
- User data automation
- Terraform outputs for communication between modules

The `compute-hybrid` module allows the infrastructure to evolve from standalone EC2 workloads toward scalable Auto Scaling Group deployments.

### Load Balancing

Application traffic is distributed using an Application Load Balancer.

The implementation includes:

- Application Load Balancer
- Target Groups
- EC2/ASG integration
- Health checks
- Listener configuration

### Monitoring & Observability

AWS CloudWatch is used to provide infrastructure-level operational visibility.

The project includes monitoring and alerting components for infrastructure health and performance.

### Security

Security is considered throughout the infrastructure design.

The architecture applies:

- IAM principles
- Security Groups
- Controlled administrative access
- Least-privilege concepts
- Network segmentation
- Secure infrastructure configuration practices

### Multi-Environment Configuration

The Terraform structure supports separate configuration for:

```text
dev
stage
prod
```

Environment-specific values are maintained separately using Terraform variable files, allowing the same infrastructure modules to be reused across environments.

---

## Implementation Journey

The repository retains its week-based structure because the infrastructure was developed incrementally.

### Phase 1 – Cloud Foundations & Networking

- Configured Terraform and AWS CLI
- Created the initial Terraform project structure
- Built a VPC with public and private subnets
- Expanded the network across multiple Availability Zones
- Added Internet Gateway and NAT connectivity
- Modularized networking components

### Phase 2 – Compute & Administrative Access

- Deployed EC2 instances
- Configured user data scripts
- Added Bastion host access
- Used Terraform outputs for inter-module communication
- Improved infrastructure access and troubleshooting workflows

### Phase 3 – Load Balancing & Monitoring

- Deployed an Application Load Balancer
- Connected compute resources to ALB Target Groups
- Configured health checks
- Added CloudWatch monitoring and alarms
- Expanded Terraform modules for operational visibility

### Phase 4 – Scalable Compute

- Developed a hybrid compute module
- Added support for both EC2 and Auto Scaling Group deployment modes
- Used Launch Templates for ASG deployments
- Tested infrastructure behavior under different compute configurations
- Integrated CloudWatch alarms with scaling-related infrastructure

### Phase 5 – Security, Reliability & Operational Improvements

- Applied IAM and least-privilege principles
- Improved network security controls
- Reviewed infrastructure configuration for security and reliability
- Improved monitoring and operational visibility
- Prepared the architecture for multi-environment deployment

### Phase 6 – Architecture Integration

- Integrated infrastructure modules into a complete architecture
- Organized dev, stage, and prod configuration
- Documented architecture and Terraform components
- Reviewed reliability, monitoring, security, and maintainability
- Prepared architecture diagrams and technical documentation

---

## How to Use

### 1. Clone the repository

```bash
git clone <repo-url>
cd 8-Week-DevOps-Platform-engineer-challenge
```

### 2. Navigate to the target implementation directory

```bash
cd Week1
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Review the execution plan

```bash
terraform plan -var-file=envs/dev/dev.tfvars
```

### 5. Apply the infrastructure

```bash
terraform apply -var-file=envs/dev/dev.tfvars
```

> Review the Terraform execution plan carefully before approving infrastructure changes.

### 6. Switch between EC2 and ASG mode

From the hybrid compute implementation onward, the compute module supports different deployment modes:

```hcl
compute_mode = "ec2" # or "asg"
```

### 7. Destroy test resources

```bash
terraform destroy -var-file=envs/dev/dev.tfvars
```

---

## Engineering Decisions

### Why Terraform Modules?

Reusable modules separate infrastructure responsibilities and make the architecture easier to maintain, test, and extend.

### Why Multi-AZ Networking?

Distributing network resources across Availability Zones provides a stronger foundation for highly available workloads.

### Why EC2 and Auto Scaling Group Modes?

Supporting both deployment patterns demonstrates how infrastructure can evolve from simple workloads toward more scalable architectures without redesigning the entire Terraform structure.

### Why an Application Load Balancer?

The ALB provides a scalable entry point for application traffic while enabling health checks and integration with Auto Scaling Groups.

### Why Separate Environments?

Separating dev, stage, and prod configuration allows infrastructure modules to remain reusable while environment-specific settings can evolve independently.

---

## Key Engineering Outcomes

Through this project, I implemented and explored:

- Modular Infrastructure as Code with Terraform
- Multi-tier AWS networking
- Public and private subnet design
- EC2 and Auto Scaling deployment patterns
- Application Load Balancing
- Infrastructure health checks
- CloudWatch monitoring and alarms
- Security Groups and IAM principles
- Environment-specific Terraform configuration
- Infrastructure troubleshooting and operational validation
- Architecture documentation and maintainable module design

The project combines my enterprise infrastructure operations background with hands-on AWS infrastructure engineering and automation.

---

## Roadmap

Potential future improvements include:

- Amazon EKS deployment
- CI/CD for Terraform using GitHub Actions
- Automated Terraform validation and security scanning
- Centralized logging and visualization
- AWS WAF integration
- AWS Secrets Manager integration
- Cost allocation tags and FinOps controls
- Automated multi-environment promotion
- Additional resilience and disaster-recovery testing

---

## Contact / Community

- LinkedIn: [Ahmed Bin Shehab](https://www.linkedin.com/in/ahmedbinshehab)
- Website: [awsbenshehab.net](https://awsbenshehab.net)

Questions, feedback, and collaboration ideas are welcome.

---

## License

© 2026 Ahmed Bin Shehab — All Rights Reserved.

This repository is shared for portfolio and educational purposes.

Reuse, redistribution, or commercial use requires written permission.

For collaboration or usage inquiries: a.shihab@hotmail.com