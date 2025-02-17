# resource "aws_launch_template" "example" {
#   name_prefix          = "example"
#   image_id             = "ami-0c55b159cbfafe1f0"
#   instance_type        = "c5.large"
#   security_group_names = [aws_security_group.ec2_sg.name]
#   key_name             = aws_key_pair.asg-key-pair.key_name
#  user_data = <<-EOF
#               #!/bin/bash
#               yum update -y
#               amazon-linux-extras enable php8.0
#               yum install -y httpd php php-mysqlnd
#               systemctl start httpd
#               systemctl enable httpd
#               cd /var/www/html
#               wget https://wordpress.org/latest.tar.gz
#               tar -xzf latest.tar.gz
#               cp -r wordpress/* .
#               rm -rf wordpress latest.tar.gz
#               chown -R apache:apache /var/www/html
#               chmod -R 755 /var/www/html
#               systemctl restart httpd
#               EOF
# }