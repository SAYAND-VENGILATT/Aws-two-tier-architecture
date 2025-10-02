output "asg_name" {
  description = "The name of the Auto Scaling Group"
  value       = aws_autoscaling_group.web_asg.name
}

output "asg_id" {
  description = "The ID of the Auto Scaling Group"
  value       = aws_autoscaling_group.web_asg.id
}

output "asg_arn" {
  description = "The ARN of the Auto Scaling Group"
  value       = aws_autoscaling_group.web_asg.arn
}

output "launch_template_id" {
  description = "The ID of the Launch Template"
  value       = aws_launch_template.web.id
}

output "launch_template_name" {
  description = "The name of the Launch Template"
  value       = aws_launch_template.web.name
}

output "launch_template_latest_version" {
  description = "The latest version of the Launch Template"
  value       = aws_launch_template.web.latest_version
}