resource "nsxt_nat_rule" "no_infra_snat" {
  display_name = "${var.env_name}-infra-no-snat"
  action       = "NO_SNAT"

  logical_router_id = nsxt_logical_tier1_router.infrastructure-t1.id
  description       = "NO NAT Rule for infra T-1 communication"
  enabled           = true
  logging           = false
  nat_pass          = true
  rule_priority     = 1023

  match_source_network      = var.infra_snat_cidr
  match_destination_network = "192.168.0.0/16"
}

resource "nsxt_nat_rule" "no_services_snat" {
  display_name = "${var.env_name}-services-no-snat"
  action       = "NO_SNAT"

  logical_router_id = nsxt_logical_tier1_router.services-t1.id
  description       = "NO NAT Rule for services T-1 communication"
  enabled           = true
  logging           = false
  nat_pass          = true
  rule_priority     = 1023

  match_source_network      = var.services_snat_cidr
  match_destination_network = "192.168.0.0/16"
}
