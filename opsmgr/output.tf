output "opsmanager_internal_ip" {
  value = var.om_internal_ipv4_address
}

output "opsmanager_external_ip" {
  value = var.om_ipv4_address
}

output "infrastructure-t1" {
  value = nsxt_logical_tier1_router.infrastructure-t1
}