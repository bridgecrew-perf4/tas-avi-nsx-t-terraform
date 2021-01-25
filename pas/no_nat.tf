resource "nsxt_nat_rule" "no_deployment_snat" {
  display_name = "${var.env_name}-deployment-no-snat"
  action       = "NO_SNAT"

  logical_router_id = nsxt_logical_tier1_router.deployment-t1.id
  description       = "NO NAT Rule for deployment T-1 communication"
  enabled           = true
  logging           = false
  nat_pass          = true
  rule_priority     = 1023

  match_source_network      = var.deployment_snat_cidr
  match_destination_network = "192.168.0.0/16"
}
