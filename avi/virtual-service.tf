
data "avi_sslkeyandcertificate" "ssl_cert1" {
  name = var.ssl_key_cert1
}
data "avi_sslprofile" "ssl_profile1" {
  name = var.ssl_profile1
}
data "avi_applicationprofile" "application_profile1" {
  name = var.application_profile1
}
data "avi_networkprofile" "network_profile1" {
  name = var.network_profile
}

resource "avi_serviceenginegroup" "default_segroup" {
  name = "Default-Group"
  cloud_ref = avi_cloud.vcenter_cloud.id
  max_vs_per_se = 1
  min_scaleout_per_vs = 2
  max_scaleout_per_vs = 4
  vcpus_per_se = 2
  memory_per_se = 4096
}

resource "avi_ipaddrgroup" "gorouter_ip_group" {
  name = var.ip_group
  dynamic "addrs" {
    for_each = toset(var.pool_members)
    content { 
      addr = addrs.value
      type = "V4"
    }
  }
}

resource "avi_healthmonitor" "gorouter_health_monitor" {
  name                = var.pool_name
  tenant_ref          = data.avi_tenant.tenant.id
  send_interval       = 5
  receive_timeout     = 4
  successful_checks   = 5
  failed_checks       = 2
  type                = "HEALTH_MONITOR_HTTP"
  monitor_port        = 8080 
  http_monitor {
    http_request       = "GET /health HTTP/1.0"
    http_response_code = ["HTTP_2XX"]
    http_response      = "ok"
    exact_http_request = false
    response_size      = 2048
  }
}

resource "avi_pool" "gorouter_pool" {
  name                = var.pool_name
  tenant_ref          = data.avi_tenant.tenant.id
  cloud_ref           = avi_cloud.vcenter_cloud.id
  lb_algorithm        = var.lb_algorithm
  ipaddrgroup_ref     = avi_ipaddrgroup.gorouter_ip_group.id
  default_server_port = 443
  health_monitor_refs = [avi_healthmonitor.gorouter_health_monitor.id]
  ssl_profile_ref     = data.avi_sslprofile.ssl_profile1.id
}

resource "avi_vsvip" "gorouter_vsvip" {
  name       = var.vip_name
  tenant_ref = data.avi_tenant.tenant.id
  cloud_ref  = avi_cloud.vcenter_cloud.id
  vip {
    vip_id = "0"
    ip_address {
      type = "V4"
      addr = var.vs_vip_address
    }
  }
}

resource "avi_virtualservice" "http_vs" {
  name                          = var.https_vs_name
  pool_ref                      = avi_pool.gorouter_pool.id
  tenant_ref                    = data.avi_tenant.tenant.id
  vsvip_ref                     = avi_vsvip.gorouter_vsvip.id
  cloud_ref                     = avi_cloud.vcenter_cloud.id
  ssl_key_and_certificate_refs  = [data.avi_sslkeyandcertificate.ssl_cert1.id]
  ssl_profile_ref               = data.avi_sslprofile.ssl_profile1.id
  application_profile_ref       = data.avi_applicationprofile.application_profile1.id
  network_profile_ref           = data.avi_networkprofile.network_profile1.id
  ign_pool_net_reach            = true
  enable_rhi                    = true
  services {
    port           = var.https_vs_port
    enable_ssl     = true
  }
  services {
    port           = var.http_vs_port
    enable_ssl     = false
  }
}