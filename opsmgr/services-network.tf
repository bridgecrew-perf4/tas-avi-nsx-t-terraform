
resource "nsxt_logical_switch" "services-ls" {
  display_name = "${var.env_name}-services-ls"

  transport_zone_id = data.nsxt_transport_zone.transport-zone.id
  admin_state       = "UP"

  description      = "PAS services Logical Switch provisioned by Terraform"
  replication_mode = "MTEP"

}

resource "nsxt_logical_port" "services-lp" {
  display_name = "${var.env_name}-services-lp"

  admin_state       = "UP"
  description       = "services Logical Port provisioned by Terraform"
  logical_switch_id = nsxt_logical_switch.services-ls.id

}

resource "nsxt_logical_router_downlink_port" "services-dp" {
  display_name = "${var.env_name}-services-dp"

  description                   = "services downlink port provisioned by Terraform"
  logical_router_id             = nsxt_logical_tier1_router.services-t1.id
  linked_logical_switch_port_id = nsxt_logical_port.services-lp.id
  ip_address                    = var.services_gateway
}

resource "nsxt_logical_tier1_router" "services-t1" {
  display_name = "${var.env_name}-T1-Services"

  description   = "PAS Tier 1 services Router provisioned by Terraform"
  failover_mode = "PREEMPTIVE"

  edge_cluster_id             = data.nsxt_edge_cluster.edge-cluster.id
  enable_router_advertisement = true
  advertise_connected_routes  = true
  advertise_lb_vip_routes     = true
  advertise_nat_routes        = true

}

resource "nsxt_logical_router_link_port_on_tier0" "t0-to-services-t1" {
  display_name = "${var.env_name}-t0-to-services-t1"

  description       = "Link Port on Logical Tier 0 Router connecting to services Tier 1 Router. Provisioned by Terraform."
  logical_router_id = data.nsxt_logical_tier0_router.rtr0.id

}

resource "nsxt_logical_router_link_port_on_tier1" "services-t1-to-t0" {
  display_name = "${var.env_name}-services-t1-to-t0"

  description                   = "Link Port on services T1 Router connecting to Logical Tier 0 Router. Provisioned by Terraform."
  logical_router_id             = nsxt_logical_tier1_router.services-t1.id
  linked_logical_router_port_id = nsxt_logical_router_link_port_on_tier0.t0-to-services-t1.id
}
