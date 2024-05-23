resource "aws_vpc" "custom_vpc" {
  cidr_block           = "10.0.0.0/28"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "task1-vpc"
  }
}

resource "aws_vpc" "custom_vpc2" {
  cidr_block           = "10.0.0.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "task1-vpc2"
  }
}
resource "aws_subnet" "subneti-1" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = "10.0.0.0/28"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subneti-1"
  }
}
resource "aws_subnet" "subneti-2" {
  vpc_id            = aws_vpc.custom_vpc2.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "subneti-2"
  }
}