resource "avi_vrfcontext" "global" {
  name = "global"
  tenant_ref = data.avi_tenant.tenant.id
  cloud_ref = avi_cloud.vcenter_cloud.id
  system_default = true
  bgp_profile {
    ibgp = false
    local_as = var.avi_bgp_asn
    num_as_path_prepend = 1
    hold_time = 180
    keepalive_interval = 60
    routing_options {
      label = "gorouter"
      learn_only_default_route = true
    }
    dynamic "peers" {
      for_each = toset(var.nsxt_t0_bgp_peer_ips)
      content { 
        advertise_snat_ip = true
        advertise_vip = true
        bfd = true
        advertisement_interval = 5
        connect_timer = 10      
        network_ref = avi_network.data_network.id
        hold_time = 180
        keepalive_interval = 60
        local_as = var.avi_bgp_asn
        remote_as = var.nsxt_t0_bgp_asn
        label = "gorouter"
        peer_ip {
          addr = peers.value
          type = "V4"
        }
        subnet {
          ip_addr {
            addr = var.avi_data_network_subnet
            type = "V4"
          }
          mask = var.avi_data_network_mask
        }
      }
    }
  }
}