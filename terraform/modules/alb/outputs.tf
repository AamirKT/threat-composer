output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.threatcomposer_alb.dns_name
}


output "alb_listener_arn" {
  description = "The ARN of the ALB HTTP listener"
  value       = aws_lb_listener.threatcomposer_alb_listener.arn
}

output "alb_zone_id" {
  description = "The zone ID of the Application Load Balancer"
  value       = aws_lb.threatcomposer_alb.zone_id
}

output "alb_tg_arn" {
  description = "The ARN of the ALB target group"
  value       = aws_lb_target_group.threatcomposer_alb_tg.arn
}

output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = aws_lb.threatcomposer_alb.arn
}




