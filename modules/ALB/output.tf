 output "alb_arn_" {
    description = "alb arn"
    value = aws_lb.web.arn
 }
 output "target_group_arns" {
   description = "Target group ARN for EC2 Autoscaling"
   value = [aws_lb_target_group.web.arn]
 }
 output "alb_dns_name" {
    description = "ALB DNS name for root output"
    value = aws_lb.web.dns_name
   
 }