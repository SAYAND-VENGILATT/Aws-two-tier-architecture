# Launch Template - defines the instance configuration
resource "aws_launch_template" "web" {
  name_prefix   = "web-template-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  
  # Network configuration
  network_interfaces {
    associate_public_ip_address = var.associate_public_ip
    security_groups             = [var.ec2_sg_id]
  }
  
  # Block device mappings
  block_device_mappings {
    device_name = "/dev/xvda"
    
    ebs {
      volume_size           = var.volume_size
      volume_type           = var.volume_type
      delete_on_termination = true
      encrypted             = true
    }
  }
  
  # User data for instance setup
  user_data = base64encode(
    coalesce(var.user_data, <<-EOF
      #!/bin/bash
      yum update -y
      yum install -y httpd
      systemctl enable httpd
      systemctl start httpd
      echo "Hello from Auto Scaling Group - $(hostname)" > /var/www/html/index.html
    EOF
    )
  )
  
  # Instance tags
  tag_specifications {
    resource_type = "instance"
    tags = merge({
      Name = "${var.name_prefix}-instance"
    }, var.tags)
  }
  
  tag_specifications {
    resource_type = "volume"
    tags = merge({
      Name = "${var.name_prefix}-volume"
    }, var.tags)
  }
  
  lifecycle {
    create_before_destroy = true
  }
  
  tags = merge({
    Name = "${var.name_prefix}-launch-template"
  }, var.tags)
}

# Auto Scaling Group
resource "aws_autoscaling_group" "web_asg" {
  name                = "${var.name_prefix}-asg"
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.subnets
  
  # Launch template configuration
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }
  
  # Load balancer integration
  target_group_arns = var.target_group_arns
  
  # Health checks
  health_check_type          = var.health_check_type
  health_check_grace_period  = var.health_check_grace_period
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  
  # Termination policies
  termination_policies = var.termination_policies
  
  # Tags for ASG and instances
  dynamic "tag" {
    for_each = merge({
      Name = "${var.name_prefix}-asg"
    }, var.tags)
    
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
  
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      desired_capacity  # Allow auto-scaling policies to manage this
    ]
  }
  
  depends_on = [aws_launch_template.web]
}

# Auto Scaling Policies (optional - for automatic scaling)
resource "aws_autoscaling_policy" "scale_up" {
  count = var.enable_scaling_policies ? 1 : 0
  
  name                   = "${var.name_prefix}-scale-up"
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300
}

resource "aws_autoscaling_policy" "scale_down" {
  count = var.enable_scaling_policies ? 1 : 0
  
  name                   = "${var.name_prefix}-scale-down"
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 300
}