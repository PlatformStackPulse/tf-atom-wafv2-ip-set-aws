output "enabled" {
  description = "Whether the module is enabled."
  value       = local.enabled
}

output "id" {
  description = "The ID of the IP set."
  value       = try(aws_wafv2_ip_set.default[0].id, "")
}

output "arn" {
  description = "The ARN of the IP set."
  value       = try(aws_wafv2_ip_set.default[0].arn, "")
}
