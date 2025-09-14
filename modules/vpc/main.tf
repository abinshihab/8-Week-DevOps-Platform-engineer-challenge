############################################
# VPC
############################################
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, { Name = "${var.project}-vpc" })
}

############################################
# Internet Gateway
############################################
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = merge(var.tags, { Name = "${var.project}-igw" })
}

############################################
# Public Subnets
############################################
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = element(var.availability_zones, count.index)

  tags = merge(var.tags, { Name = "${var.project}-public-${count.index+1}", Tier = "public" })
}

############################################
# Private Subnets
############################################
resource "aws_subnet" "private" {
  count                   = length(var.private_subnet_cidrs)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.private_subnet_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone       = element(var.availability_zones, count.index)

  tags = merge(var.tags, { Name = "${var.project}-private-${count.index+1}", Tier = "private" })
}

########################
# Elastic IPs for NAT
########################
resource "aws_eip" "nat" {
  count = length(var.public_subnet_cidrs)
  tags  = merge(var.tags, { Name = "${var.project}-nat-eip-${count.index+1}" })
}

resource "aws_nat_gateway" "nat" {
  count         = length(aws_subnet.public)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  depends_on    = [aws_internet_gateway.this]

  tags = merge(var.tags, { Name = "${var.project}-nat-${count.index+1}" })
}

############################################
# Public Route Table
############################################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, { Name = "${var.project}-public-rt" })
}

resource "aws_route" "public_default" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public_assoc" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}



############################################
# Private Route Tables
############################################
resource "aws_route_table" "private" {
  count  = length(aws_subnet.private)
  vpc_id = aws_vpc.this.id
  tags   = merge(var.tags, { Name = "${var.project}-private-rt-${count.index+1}" })
}

resource "aws_route" "private_nat" {
  count                  = length(aws_subnet.private)
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat.*.id, count.index % length(aws_nat_gateway.nat))
}

########################
# Route Table Associations
########################


resource "aws_route_table_association" "private_assoc" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
