resource "aws_vpc" "custom_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "task2-vpc"
  }
}
variable "vpc_availability_zones" { 
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-east-1a", "us-east-1b"]
}

resource "aws_subnet" "subnet-public" {
  vpc_id            = aws_vpc.custom_vpc.id
  count             = length(var.vpc_availability_zones)
  cidr_block        = cidrsubnet(aws_vpc.custom_vpc.cidr_block, 8, count.index + 1)
  availability_zone = element(var.vpc_availability_zones, count.index)
  tags = {
    Name = "task2-subnet-public"
  }
}  

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.custom_vpc.id
  count             = length(var.vpc_availability_zones)
  cidr_block        = cidrsubnet(aws_vpc.custom_vpc.cidr_block, 8, count.index + 3)
  availability_zone = element(var.vpc_availability_zones, count.index)
  tags = {
    Name = "task2-subnet-private"
  }
}

resource "aws_internet_gateway" "igw_vpc" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = "task2-Internet Gateway"
  }
}

resource "aws_eip" "eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw_vpc]
}
