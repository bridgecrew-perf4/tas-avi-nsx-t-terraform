
resource "nsxt_logical_switch" "deployment-ls" {
  display_name = "${var.env_name}-deployment-ls"

  transport_zone_id = data.nsxt_transport_zone.transport-zone.id
  admin_state       = "UP"

  description      = "Deployment Logical Switch provisioned by Terraform"
  replication_mode = "MTEP"

}

resource "nsxt_logical_port" "deployment-lp" {
  display_name = "${var.env_name}-deployment-lp"

  admin_state       = "UP"
  description       = "Deployment Logical Port provisioned by Terraform"
  logical_switch_id = nsxt_logical_switch.deployment-ls.id

}

resource "nsxt_logical_router_downlink_port" "deployment-dp" {
  display_name = "${var.env_name}-deployment-dp"

  description                   = "Deployment downlink port provisioned by Terraform"
  logical_router_id             = nsxt_logical_tier1_router.deployment-t1.id
  linked_logical_switch_port_id = nsxt_logical_port.deployment-lp.id
  ip_address                    = var.deployment_gateway
}

resource "nsxt_logical_tier1_router" "deployment-t1" {
  display_name = "${var.env_name}-T1-Deployment"

  description   = "PAS Tier 1 Deployment Router provisioned by Terraform"
  failover_mode = "PREEMPTIVE"

  edge_cluster_id             = data.nsxt_edge_cluster.edge-cluster.id
  enable_router_advertisement = true
  advertise_connected_routes  = true
  advertise_nat_routes        = true
  
}

resource "nsxt_logical_router_link_port_on_tier0" "t0-to-deployment-t1" {
  display_name = "${var.env_name}-t0-to-deployment-t1"

  description       = "Link Port on Logical Tier 0 Router connecting to Deployment Tier 1 Router. Provisioned by Terraform."
  logical_router_id = data.nsxt_logical_tier0_router.rtr0.id

}

resource "nsxt_logical_router_link_port_on_tier1" "deployment-t1-to-t0" {
  display_name = "${var.env_name}-deployment-t1-to-t0"

  description                   = "Link Port on Deployment T1 Router connecting to Logical Tier 0 Router. Provisioned by Terraform."
  logical_router_id             = nsxt_logical_tier1_router.deployment-t1.id
  linked_logical_router_port_id = nsxt_logical_router_link_port_on_tier0.t0-to-deployment-t1.id
}

resource "nsxt_nat_rule" "snat" {
  display_name = "${var.env_name}-pas-deployment-snat"
  action       = "SNAT"

  logical_router_id = nsxt_logical_tier1_router.deployment-t1.id
  description       = "SNAT Rule for PAS Deployment Network"
  enabled           = true
  logging           = false
  nat_pass          = true

  match_source_network = var.deployment_snat_cidr
  translated_network   = var.deployment_snat_ip
}
