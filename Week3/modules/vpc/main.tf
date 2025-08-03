resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-vpc"
    }
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-igw"
    }
  )
}

resource "aws_subnet" "public" {
  for_each = toset(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.key
  availability_zone       = var.availability_zones[index(var.public_subnet_cidrs, each.key)]
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-public-${each.key}"
    }
  )
}

resource "aws_subnet" "private" {
  for_each = toset(var.private_subnet_cidrs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.key
  availability_zone = var.availability_zones[index(var.private_subnet_cidrs, each.key)]

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-private-${each.key}"
    }
  )
}
resource "aws_security_group" "vpc_default_sg" {
  name        = "${var.name}-default-sg"
  description = "Default SG for ${var.name} VPC"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.name}-default-sg"
  })
}
