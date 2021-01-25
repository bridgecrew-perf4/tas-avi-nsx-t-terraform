variable "env_name" {
  type = string
}

variable "nsxt_transport_zone" {
  default     = ""
  description = "The name of the overlay transport zone."
  type        = string
}

variable "nsxt_edge_cluster" {
  default     = ""
  description = "The name of the edge cluster."
  type        = string
}

variable "nsxt_t0_router" {
  default     = ""
  description = "The name of the logical tier 0 router."
  type        = string
}

variable "deployment_gateway" {
  default = "192.168.2.1/24"
}

variable "deployment_snat_cidr" {
  default = "192.168.2.0/24"
}

variable "deployment_snat_ip" {
}

variable "pas_ip_orgs_block" {
  default = "192.168.128.0/17"
}

variable "pas_tag" {}

variable "snat_ip_pool_range" {}

variable "snat_ip_pool_cidr" {}

variable "snat_ip_pool_gateway" {}
