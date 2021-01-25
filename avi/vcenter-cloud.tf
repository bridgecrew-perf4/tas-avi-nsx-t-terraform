data "avi_tenant" "tenant" {
  name = var.tenant
}

resource "avi_cloud" "vcenter_cloud" {
  name         = var.cloud_name
  tenant_ref   = data.avi_tenant.tenant.id
  vtype        = "CLOUD_VCENTER"
  dhcp_enabled = false
  license_tier = var.vcenter_license_tier
  license_type = var.vcenter_license_type
  vcenter_configuration {
    datacenter         = var.vcenter_datacenter
    management_network = var.avi_se_mgmt_network_name
    password           = var.vcenter_password
    privilege          = "WRITE_ACCESS"
    username           = var.vcenter_username
    vcenter_url        = var.vcenter_url
    management_ip_subnet {
      mask = var.avi_se_mgmt_network_mask
      ip_addr {
        addr = var.avi_se_mgmt_network_subnet
        type = "V4"
      }
    }
  }
}