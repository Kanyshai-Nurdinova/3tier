# Create ALB
# Load Balancer
resource "aws_lb" "main" {
  name               = "main-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.asg_sg.id]
  subnets           = [aws_subnet.private-1.id, aws_subnet.private-2.id, aws_subnet.private-3.id ]
}

# Target Group
resource "aws_lb_target_group" "main" {
  name     = "asg-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.task-vpc.id
}

# Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}


# ALB Security Group
resource "aws_security_group" "asg_sg" {
  vpc_id = aws_vpc.task-vpc.id

 # Allow HTTP/HTTPS from ALL
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Allow HTTP/HTTPS from ALL
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Allow All Outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Route 53 CNAME record pointing ALB to blog.example.com

resource "aws_route53_record" "www" {
  zone_id = "Z031535353A87956940A"
  name    = "www.caramans.com"
  type    = "CNAME"
  ttl     = 300
  records = [module.alb.lb_dns_name]
}

