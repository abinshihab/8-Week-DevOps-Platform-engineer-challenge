# Week 8 – QA Validation Checklist
This document ensures that all environments (dev, stage, prod) are consistent, stable, and ready for release.

---

## 1. Terraform Backend Validation
| Check | dev | stage | prod |
|-------|-----|--------|-------|
| Backend initialized successfully (`terraform init`) | ☐ | ☐ | ☐ |
| State file readable | ☐ | ☐ | ☐ |
| No drift detected (`terraform plan` shows consistent resources) | ☐ | ☐ | ☐ |

Notes:
- Used `-reconfigure` to safely switch environments without migrating state.

---

## 2. VPC Module Validation
| Item | Expected | dev | stage | prod |
|------|----------|-----|--------|-------|
| VPC CIDR correct | e.g., 10.x.x.x/16 | ☐ | ☐ | ☐ |
| Public subnets CIDRs correct | | ☐ | ☐ | ☐ |
| Private subnets CIDRs correct | | ☐ | ☐ | ☐ |
| Availability Zones correct | | ☐ | ☐ | ☐ |
| Internet Gateway created (if enabled) | | ☐ | ☐ | ☐ |
| NAT Gateways correct per environment | dev: off / stage: on / prod: on | ☐ | ☐ | ☐ |

Notes:
- Ensure no NAT Gateways in dev (cost control).

---

## 3. Routing Validation
| Check | dev | stage | prod |
|--------|-----|--------|-------|
| Public route table points to IGW | ☐ | ☐ | ☐ |
| Private route table points to NAT (if enabled) | ☐ | ☐ | ☐ |
| No conflicting or duplicate routes | ☐ | ☐ | ☐ |

---

## 4. ALB Validation
| Item | dev | stage | prod |
|-------|-----|--------|-------|
| ALB created | ☐ | ☐ | ☐ |
| Listener on port 80 exists | ☐ | ☐ | ☐ |
| Target group created | ☐ | ☐ | ☐ |
| Health check path correct ("/") | ☐ | ☐ | ☐ |
| SG allows inbound 80/443 | ☐ | ☐ | ☐ |

---

## 5. ASG / Compute Validation
| Check | dev | stage | prod |
|--------|-----|--------|-------|
| Launch template created | ☐ | ☐ | ☐ |
| ASG created with desired/min/max capacity | ☐ | ☐ | ☐ |
| Scaling policies exist | ☐ | ☐ | ☐ |
| IAM instance profile attached | ☐ | ☐ | ☐ |
| User-data script loads correctly | ☐ | ☐ | ☐ |

---

## 6. RDS Validation
| Item | dev | stage | prod |
|-------|-----|--------|-------|
| Correct engine/version | ☐ | ☐ | ☐ |
| Correct instance type | ☐ | ☐ | ☐ |
| Multi-AZ matches environment | dev: off / prod: on | ☐ | ☐ | ☐ |
| DB subnet group created | ☐ | ☐ | ☐ |
| Security group rules correct | ☐ | ☐ | ☐ |

---

## 7. CloudWatch Monitoring Validation
| Alarm | dev | stage | prod |
|--------|-----|--------|-------|
| ALB UnhealthyHostCount alarm exists | ☐ | ☐ | ☐ |
| ALB HighRequestCount alarm exists | ☐ | ☐ | ☐ |
| ASG CPU High alarm exists | ☐ | ☐ | ☐ |
| ASG CPU Low alarm exists | ☐ | ☐ | ☐ |
| SNS Topic exists | ☐ | ☐ | ☐ |
| Email subscription confirmed | ☐ | ☐ | ☐ |
| Dashboard JSON loads without errors | ☐ | ☐ | ☐ |

---

## 8. Lambda AI Agent Validation (if used)
| Check | dev | stage | prod |
|--------|-----|--------|-------|
| Lambda function deployed | ☐ | ☐ | ☐ |
| IAM role permissions correct | ☐ | ☐ | ☐ |
| CloudWatch logs for Lambda exist | ☐ | ☐ | ☐ |
| AI agent receives metrics inputs | ☐ | ☐ | ☐ |
| AI agent decision logs valid | ☐ | ☐ | ☐ |

---

## 9. Tagging Consistency
All resources must include:
- Environment
- Owner
- Project

| Check | dev | stage | prod |
|--------|-----|--------|-------|
| Tags match across all resources | ☐ | ☐ | ☐ |

---

## 10. Final Verification
| Item | Status |
|-------|---------|
| All modules validated | ☐ |
| All environments consistent | ☐ |
| No high-cost resources in dev | ☐ |
| No missing SSM parameters | ☐ |
| Ready for Week 8 handoff | ☐ |

---

# Summary
Provide any issues or drifts discovered and how they were fixed.

