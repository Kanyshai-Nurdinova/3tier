module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "8.0.1"

  name                = "example-asg"
  min_size           = 1
  max_size           = 99
  desired_capacity   = 1
  vpc_zone_identifier = data.terraform_remote_state.vpc.outputs.private_subnets

  health_check_type = "EC2"
  
  # Define launch template correctly
  
    launch_template_name          = "example-asg"
    launch_template_description   = "Launch template example"
    image_id      = "ami-0952a345dcc6cd699"
    instance_type = "t3.micro"
    ebs_optimized = false
  

  tags = {
    Name        = "asg-instance"
    Environment = "dev"
  }
}

