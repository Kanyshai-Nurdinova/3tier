resource "aws_launch_template" "asg" {
  name_prefix   = var.name_prefix
  image_id      = var.image_id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.asg_sg.id]
  }
}

resource "aws_autoscaling_group" "wordpress" {
  vpc_zone_identifier = var.subnets
  desired_capacity   = var.desired_capacity
  max_size           = var.max_size
  min_size           = var.min_size

  launch_template {
    id      = aws_launch_template.asg.id
    version = "$Latest"
    
  }
}


resource "aws_elb" "wordpress" {
  name               = "wordpress-terraform-elbs"
  subnets  = var.subnets
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:80"
    interval            = 30
  }
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
}



resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.wordpress.id
  elb                    = aws_elb.wordpress.id
}