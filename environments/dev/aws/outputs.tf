output "app_url" {
  description = "Load balancer URL — open this in your browser to see the app"
  value       = "http://${module.ecs.alb_dns_name}"
}

output "log_group" {
  description = "CloudWatch log group for container logs"
  value       = module.ecs.log_group_name
}
