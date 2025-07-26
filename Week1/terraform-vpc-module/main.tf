resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = merge(
    {
      Name        = "${var.environment}-vpc"
      Environment = var.environment
    },
    var.tags
  )
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name        = "${var.environment}-public-${count.index + 1}"
      Environment = var.environment
      Type        = "public"
    },
    var.tags
  )
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    {
      Name        = "${var.environment}-private-${count.index + 1}"
      Environment = var.environment
      Type        = "private"
    },
    var.tags
  )
}
