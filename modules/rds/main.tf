############################################
# RDS Instance (Multi-AZ)
############################################

# --- Subnet Group for RDS ---
resource "aws_db_subnet_group" "this" {
  name       = lower("rds-${trimspace(var.project)}-${trimspace(var.environment)}-subnet-group")
  subnet_ids = var.private_subnets

  tags = merge(var.tags, {
    Name     = lower("rds-${trimspace(var.project)}-${trimspace(var.environment)}-subnet-group"),
    Project  = var.project,
    Env      = var.environment
  })
}

# --- RDS Database Instance ---
resource "aws_db_instance" "db" {
  # ✅ Safe identifier (AWS-compliant, starts with a letter)
  identifier             = lower("rds-${trimspace(var.project)}-${trimspace(var.environment)}-db")

  # --- Core Configuration ---
  allocated_storage      = var.allocated_storage
  max_allocated_storage  = var.max_allocated_storage
  engine                 = var.engine
  engine_version         = "8.0.35"                   # ✅ Valid MySQL version
  instance_class         = var.instance_class

  # --- Credentials ---
  username               = var.username
  password               = var.password

  # --- Network Settings ---
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.security_groups
  multi_az               = true
  publicly_accessible    = false
  skip_final_snapshot    = true

  # --- Backup & Lifecycle ---
  backup_retention_period = var.backup_retention_period
  deletion_protection     = false

  # --- Dependencies ---
  depends_on = [
    aws_db_subnet_group.this      # ✅ ensures subnet group is ready
  ]

  # --- Tags ---
  tags = merge(var.tags, {
    Name      = lower("rds-${trimspace(var.project)}-${trimspace(var.environment)}-db"),
    Project   = var.project,
    Env       = var.environment,
    ManagedBy = "Terraform"
  })
}

