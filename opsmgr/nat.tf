resource "nsxt_nat_rule" "dnat-om" {
  display_name = "${var.env_name}-dnat-om"
  action       = "DNAT"

  logical_router_id = nsxt_logical_tier1_router.infrastructure-t1.id
  description       = "DNAT Rule for Ops Manager"
  enabled           = true
  logging           = false
  nat_pass          = true

  match_destination_network = var.om_ipv4_address
  translated_network        = var.om_internal_ipv4_address
}

resource "nsxt_nat_rule" "infra-snat" {
  display_name = "${var.env_name}-infra-snat"
  action       = "SNAT"

  logical_router_id = nsxt_logical_tier1_router.infrastructure-t1.id
  description       = "SNAT Rule for Infrastructure Network"
  enabled           = true
  logging           = false
  nat_pass          = true

  match_source_network = var.infra_snat_cidr
  translated_network   = var.infra_snat_ip
}

resource "nsxt_nat_rule" "services-snat" {
  display_name = "${var.env_name}-service-snat"
  action       = "SNAT"

  logical_router_id = nsxt_logical_tier1_router.services-t1.id
  description       = "SNAT Rule for services Network"
  enabled           = true
  logging           = false
  nat_pass          = true

  match_source_network = var.services_snat_cidr
  translated_network   = var.services_snat_ip
}
