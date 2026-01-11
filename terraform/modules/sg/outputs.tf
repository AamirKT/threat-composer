output "ecs_security_group_id" {
  description = "The security group ID of the ECS tasks"
  value       = aws_security_group.ecs_sg.id
}

output "alb_security_group_id" {
  description = "The security group ID of the Application Load Balancer"
  value       = aws_security_group.alb_sg.id
}