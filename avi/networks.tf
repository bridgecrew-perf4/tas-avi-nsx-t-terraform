resource "avi_network" "avi_se_mgmt" {
  name = var.avi_se_mgmt_network_name
  tenant_ref = data.avi_tenant.tenant.id
  cloud_ref = avi_cloud.vcenter_cloud.id
  dhcp_enabled = false
  configured_subnets {
      prefix {
          ip_addr {
              addr = var.avi_se_mgmt_network_subnet
              type = "V4"
          }
          mask = var.avi_se_mgmt_network_mask
      }
      static_ranges {
          begin {
              addr = var.avi_se_mgmt_network_start_ip
              type = "V4"
          }
          end {
              addr = var.avi_se_mgmt_network_end_ip
              type = "V4"
          }
      }
  }
}

resource "avi_network" "data_network" {
  name = var.avi_data_network_name
  tenant_ref = data.avi_tenant.tenant.id
  cloud_ref = avi_cloud.vcenter_cloud.id
  dhcp_enabled = false
  configured_subnets {
      prefix {
          ip_addr {
              addr = var.avi_data_network_subnet
              type = "V4"
          }
          mask = var.avi_data_network_mask
      }
      static_ranges {
          begin {
              addr = var.avi_data_network_start_ip
              type = "V4"
          }
          end {
              addr = var.avi_data_network_end_ip
              type = "V4"
          }
      }
  }
}