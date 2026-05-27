output "ip_set_id" {
  description = "The ID of the WAFv2 IP Set."
  value       = try(aws_wafv2_ip_set.this[0].id, "")
}

output "ip_set_arn" {
  description = "The ARN of the WAFv2 IP Set."
  value       = try(aws_wafv2_ip_set.this[0].arn, "")
}

output "enabled" {
  description = "Whether the module is enabled."
  value       = local.enabled
}
