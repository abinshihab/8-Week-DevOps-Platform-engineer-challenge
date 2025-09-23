############################################
# RDS Instance (Multi-AZ)
############################################

resource "aws_db_subnet_group" "this" {
  name       = "${var.project}-${var.environment}-rds-subnet-group"
  subnet_ids = var.private_subnets

  tags = merge(var.tags, {
    Name = "${var.project}-${var.environment}-rds-subnet-group"
  })
}

resource "aws_db_instance" "db" {
  identifier              = "${var.project}-${var.environment}-db"
  allocated_storage       = var.allocated_storage
  max_allocated_storage   = var.max_allocated_storage
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  username                = var.username
  password                = var.password
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = var.security_groups
  skip_final_snapshot     = true
  multi_az                = true
  publicly_accessible     = false

  backup_retention_period = var.backup_retention_period
  deletion_protection     = false

  tags = merge(var.tags, {
    Name = "${var.project}-${var.environment}-db"
  })
}
