resource "aws_security_group" "lb_sg" {
  name        = "besfort-lb-sg"
  description = "Security Group for Application Load Balancer-Route53"

  vpc_id = "vpc-01ba652d9d185fb64"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "besfort-lb-sg"
  }
}

resource "aws_lb" "lb" {
  name               = "besfort-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-09a25306cdf426046"] 
  subnets          = ["subnet-03e03ff98a74e9f6e", "subnet-0c775e81893ce64be"]
}