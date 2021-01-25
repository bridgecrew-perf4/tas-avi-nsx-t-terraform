resource "avi_serviceenginegroup" "gslb_segroup" {
  name = var.gslb_vip_name
  cloud_ref = avi_cloud.vcenter_cloud.id
  max_vs_per_se = 1
  min_scaleout_per_vs = 2
  max_scaleout_per_vs = 4
}

resource "avi_vsvip" "gslb_vsvip" {
  name       = var.gslb_vip_name
  tenant_ref = data.avi_tenant.tenant.id
  cloud_ref  = avi_cloud.vcenter_cloud.id
  vip {
    vip_id = "1"
    ip_address {
      type = "V4"
      addr = var.gslb_vs_vip_address
    }
  }
}

data "avi_networkprofile" "system_tcp_proxy" {
  name = "System-TCP-Proxy"
}
data "avi_networkprofile" "system_udp_per_pkt" {
  name = "System-UDP-Per-Pkt"
}
data "avi_applicationprofile" "system_dns" {
  name = "System-DNS"
}

resource "avi_virtualservice" "gslb_vs" {
  name                          = var.gslb_vip_name
  tenant_ref                    = data.avi_tenant.tenant.id
  vsvip_ref                     = avi_vsvip.gslb_vsvip.id
  cloud_ref                     = avi_cloud.vcenter_cloud.id
  se_group_ref                  = avi_serviceenginegroup.gslb_segroup.id
  application_profile_ref       = data.avi_applicationprofile.system_dns.id
  network_profile_ref           = data.avi_networkprofile.system_udp_per_pkt.id
  enable_rhi                    = true
  services {
    port = 53
    enable_ssl = false
  }
  services {
    port = 53
    enable_ssl = false
    override_network_profile_ref = data.avi_networkprofile.system_tcp_proxy.id
  }
}
