output "environment_url" {
  description = "URL to the deployment in particular environment"
  value       = module.alb.lb_dns_name
}
