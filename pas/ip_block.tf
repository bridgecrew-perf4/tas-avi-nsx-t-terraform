resource "nsxt_ip_block" "pas_ip_orgs_block" {
  description  = "ip_block for pas orgs provisioned by Terraform"
  display_name = "pas_orgs_ip_block"
  cidr         = var.pas_ip_orgs_block
  tag {
    scope = "ncp/cluster"
    tag   = var.pas_tag
  }
}
