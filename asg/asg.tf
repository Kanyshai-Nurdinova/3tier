# resource "aws_autoscaling_group" "example" {
#   availability_zones = data.aws_availability_zones.all.names
#   desired_capacity   = 3
#   max_size           = 99
#   min_size           = 3
#   mixed_instances_policy {
#     launch_template {
#       launch_template_specification {
#         launch_template_id = aws_launch_template.example.id
#       }
#       override {
#         instance_type     = "c4.large"
#         weighted_capacity = "1"
#       }
#       override {
#         instance_type     = "c3.large"
#         weighted_capacity = "2"
#       }
#       override {
#         instance_type     = "m5.large"
#         weighted_capacity = "3"
#       }
#     }
#   }
# }

resource "aws_autoscaling_group" "wordpress_asg" {
  availability_zones = data.aws_availability_zones.all.names
  desired_capacity    = 2
  min_size           = 1
  max_size           = 3
  launch_configuration = aws_launch_configuration.wordpress_lc.id
}

resource "aws_launch_configuration" "wordpress_lc" {
  name          = "wordpress-lc"
  image_id      = "ami-07f463d9d4a6f005f"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd php php-mysqlnd
              systemctl start httpd
              systemctl enable httpd
              EOF
}
