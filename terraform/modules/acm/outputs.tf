output "certificate_arn" {
  description = "The ARN of the SSL certificate associated with the ALB"
  value       = aws_acm_certificate.cert.arn
}

output "zone_id" {
  description = "The Route 53 Hosted Zone ID for the ALB"
  value       = var.alb_zone_id
}

output "acm_certificate_domain" {
  description = "The domain name for which the ACM certificate is issued"
  value       = aws_acm_certificate.cert.domain_name
}

output "domain_name" {
  description = "The domain name for which the ACM certificate is issued"
  value       = var.domain_name
}