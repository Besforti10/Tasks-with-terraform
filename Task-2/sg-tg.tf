resource "aws_security_group" "alb_sg" {
  name        = "task2-alb-sg"
  description = "SG per ALB"

  vpc_id = aws_vpc.custom_vpc.id
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
    Name = "task2-alb-sg"
  }
}

resource "aws_security_group" "ecs_sg" {
  name        = "task2-web-sg"
  description = "SG per web"

  vpc_id = aws_vpc.custom_vpc.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "task2-lb-web"
  }
}

resource "aws_lb_target_group" "alb_task2_tg" { 
  name     = "task2-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.custom_vpc.id
  tags = {
    Name = "task2-tg"
  }
  health_check { 
    path = "/"
    healthy_threshold = 5
    unhealthy_threshold = 3
    timeout = 2
    interval = 4
    matcher = "200"
}
}

resource "aws_lb_target_group" "nlb_target_group" { 
  name     = "nlb-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.custom_vpc.id
}