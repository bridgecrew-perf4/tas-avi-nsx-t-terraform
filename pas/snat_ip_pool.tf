resource "nsxt_ip_pool" "snat_ip_pool" {
  description = "pas snat ip pool provisioned by Terraform"
  display_name = "PAS_SNAT_POOL"

  tag {
    scope = "ncp/cluster"
    tag   = var.pas_tag
  }

  subnet {
    allocation_ranges = [var.snat_ip_pool_range]
    cidr              = var.snat_ip_pool_cidr
  }
}
