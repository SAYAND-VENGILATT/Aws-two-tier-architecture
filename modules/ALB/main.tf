resource "aws_lb" "web" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    =[var.alb_sg_id]
  subnets           = var.public_subnets

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "web" {
  name     = var.target_grp_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
} 

