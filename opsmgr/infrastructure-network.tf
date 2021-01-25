
resource "nsxt_logical_switch" "infrastructure-ls" {
  display_name = "${var.env_name}-infrastructure-ls"

  transport_zone_id = data.nsxt_transport_zone.transport-zone.id
  admin_state       = "UP"

  description      = "Infrastructure Logical Switch provisioned by Terraform"
  replication_mode = "MTEP"

}

resource "nsxt_logical_port" "infrastructure-lp" {
  display_name = "${var.env_name}-infrastructure-lp"

  admin_state       = "UP"
  description       = "infrastructure Logical Port provisioned by Terraform"
  logical_switch_id = nsxt_logical_switch.infrastructure-ls.id

}

resource "nsxt_logical_router_downlink_port" "infrastructure-dp" {
  display_name = "${var.env_name}-infrastructure-dp"

  description                   = "infrastructure downlink port provisioned by Terraform"
  logical_router_id             = nsxt_logical_tier1_router.infrastructure-t1.id
  linked_logical_switch_port_id = nsxt_logical_port.infrastructure-lp.id
  ip_address                    = var.infrastructure_gateway
}

resource "nsxt_logical_tier1_router" "infrastructure-t1" {
  display_name = "${var.env_name}-T1-Infrastructure"

  description   = "PAS Tier 1 infrastructure Router provisioned by Terraform"
  failover_mode = "PREEMPTIVE"

  edge_cluster_id             = data.nsxt_edge_cluster.edge-cluster.id
  enable_router_advertisement = true
  advertise_connected_routes  = true
  advertise_lb_vip_routes     = true
  advertise_nat_routes        = true

}

resource "nsxt_logical_router_link_port_on_tier0" "t0-to-infrastructure-t1" {
  display_name = "${var.env_name}-t0-to-infrastructure-t1"

  description       = "Link Port on Logical Tier 0 Router connecting to infrastructure Tier 1 Router. Provisioned by Terraform."
  logical_router_id = data.nsxt_logical_tier0_router.rtr0.id

}

resource "nsxt_logical_router_link_port_on_tier1" "infrastructure-t1-to-t0" {
  display_name = "${var.env_name}-infrastructure-t1-to-t0"

  description                   = "Link Port on infrastructure T1 Router connecting to Logical Tier 0 Router. Provisioned by Terraform."
  logical_router_id             = nsxt_logical_tier1_router.infrastructure-t1.id
  linked_logical_router_port_id = nsxt_logical_router_link_port_on_tier0.t0-to-infrastructure-t1.id
}
