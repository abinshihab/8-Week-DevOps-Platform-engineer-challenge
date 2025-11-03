############################################
# RDS Module Variables (Validated Version)
############################################

# --- Project & Environment ---
variable "project" {
  description = "Project name (must start with a lowercase letter, e.g., cc8weeks)"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]*$", var.project))
    error_message = "Project name must start with a lowercase letter and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "environment" {
  description = "Deployment environment (dev, stage, or prod)"
  type        = string

  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "Environment must be one of: dev, stage, or prod."
  }
}

# --- Tags ---
variable "tags" {
  description = "Map of tags to apply"
  type        = map(string)
  default     = {}
}

# --- Networking ---
variable "private_subnets" {
  description = "List of private subnet IDs for RDS"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs for RDS"
  type        = list(string)
}

# --- Engine ---
variable "engine" {
  description = "Database engine type"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
  default     = "8.0.36"
}

# --- Instance Config ---
variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.medium"
}

variable "allocated_storage" {
  description = "Initial allocated storage (GB)"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Maximum autoscaled storage (GB)"
  type        = number
  default     = 100
}

# --- Credentials ---
variable "username" {
  description = "Master username for RDS"
  type        = string
}

variable "password" {
  description = "Master password for RDS"
  type        = string
  sensitive   = true
}

# --- Backup & Retention ---
variable "backup_retention_period" {
  description = "Backup retention period (in days)"
  type        = number
  default     = 7
}
