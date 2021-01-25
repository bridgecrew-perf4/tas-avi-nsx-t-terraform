variable "avi_username" {                                                                                                                                               
  type    = string
  default = ""
}
variable "avi_password" {
  type    = string
  default = ""
}
variable "avi_controller" {
  type    = string
  default = ""
}
variable "avi_version" {
  type    = string
  default = "18.2.10"
}
variable "tenant" {
  type    = string
  default = "admin"
}
variable "cloud_name" {
  type    = string
  default = "tf_vmware_cloud"
}
variable "vcenter_username" {
  type    = string
  default = ""
}
variable "vcenter_password" {
  type    = string
  default = ""
}
variable "vcenter_datacenter" {
  type    = string
  default = ""
}
variable "vcenter_privilege" {
  type    = string
  default = "WRITE_ACCESS"
}
variable "vcenter_url" {
  type    = string
  default = ""
}
variable "vcenter_license_tier" {
  type    = string
  default = "ENTERPRISE_18"
}
variable "vcenter_license_type" {
  type    = string
  default = "LIC_CORES"
}
variable "ip_group" {
  type    = string
  default = "gorouter-poolmember-ipgroup"
}
variable "pool_name" {
  type    = string
  default = "gorouter-pool"
}
variable "vip_name" {
  type    = string
  default = "gorouter-vip"
}
variable "lb_algorithm" {
  type    = string
  default = "LB_ALGORITHM_ROUND_ROBIN"
}
variable "pool_members" {
  type = any
  default = []
}
variable "ssl_key_cert1" {
  type    = string
  default = "System-Default-Cert"
}
variable "ssl_profile1" {
  type    = string
  default = "System-Standard"
}
variable "application_profile1" {
  type    = string
  default = "System-Secure-HTTP"
}
variable "vs_vip_address" {
  type    = string
  default = ""
}
variable "https_vs_name" {
  type    = string
  default = "gorouter-https-vs"
}
variable "http_vs_port" {
  type    = number
  default = "80"
}
variable "https_vs_port" {
  type    = number
  default = "443"
}
variable "network_profile" {
  type    = string
  default = "System-TCP-Proxy"
}

variable "avi_se_mgmt_network_name" {
  type    = string
  default = ""
}
variable "avi_se_mgmt_network_subnet" {
  type    = string
  default = ""
}
variable "avi_se_mgmt_network_mask" {
  type    = string
  default = ""
}
variable "avi_se_mgmt_network_start_ip" {
  type    = string
  default = ""
}
variable "avi_se_mgmt_network_end_ip" {
  type    = string
  default = ""
}
variable "avi_data_network_name" {
  type    = string
  default = ""
}
variable "avi_data_network_subnet" {
  type    = string
  default = ""
}
variable "avi_data_network_mask" {
  type    = string
  default = ""
}
variable "avi_data_network_start_ip" {
  type    = string
  default = ""
}
variable "avi_data_network_end_ip" {
  type    = string
  default = ""
}
variable "avi_bgp_asn" {
  type    = string
  default = ""
}
variable "nsxt_t0_bgp_asn" {
  type    = string
  default = ""
}
variable "nsxt_t0_bgp_peer_ips" {
  type = any
  default = []
}

variable "gslb_vs_vip_address" {
  type    = string
  default = ""
}
variable "gslb_vip_name" {
  type    = string
  default = "g-dns"
}