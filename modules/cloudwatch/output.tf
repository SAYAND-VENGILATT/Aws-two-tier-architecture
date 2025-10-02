output "asg_cpu_alarm_name" {
    description = "ASG CPU ALARM NAME"
    value = aws_cloudwatch_metric_alarm.asg_cpu_high.alarm_name
}
output "rds_cpu_high_name" {
    description = "RDS CPU ALARM NAME"
    value = aws_cloudwatch_metric_alarm.rds_cpu_high.alarm_name
}