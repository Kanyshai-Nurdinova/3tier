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
 // availability_zones = data.aws_availability_zones.all.names
  vpc_zone_identifier = [aws_subnet.public-1.id, aws_subnet.public-2.id, aws_subnet.public-3.id]
  desired_capacity    = 2
  min_size           = 1
  max_size           = 3
  

  launch_template {
    id      = aws_launch_template.wordpress_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "wordpress-asg-instance"
    propagate_at_launch = true
  }
}