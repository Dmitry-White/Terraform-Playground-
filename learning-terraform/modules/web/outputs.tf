output "environment_url" {
  description = "URL to the deployment in particular environment"
  value       = module.web_alb.lb_dns_name
}
