
variable "global_snat_cidr" {
  default     = "192.168.0.0/16"
  description = "The source network for outbound snat"
  type        = string
}

variable "global_snat_ip" {
  description = "The external ip to snat all network outbound traffic out of T0"
  type        = string
}

variable "infra_snat_cidr" {
  default     = "192.168.1.0/24"
  description = "The source network for infrastructure network"
  type        = string
}

variable "infra_snat_ip" {
  description = "The external ip to snat infra network outbound traffic"
  type        = string
}

variable "services_snat_cidr" {
  default     = "192.168.3.0/24"
  description = "The source network for services network"
  type        = string
}

variable "services_snat_ip" {
  description = "The external ip to snat services network outbound traffic"
  type        = string
}

variable "env_name" {
  type = string
}


variable "om_ipv4_address" {
  type = string
}

variable "om_internal_ipv4_address" {
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

variable "infrastructure_gateway" {
  default = "192.168.1.1/24"
}

variable "nsxt_t0_router" {
  default     = ""
  description = "The name of the logical tier 0 router."
  type        = string
}
variable "services_gateway" {
  default     = "192.168.3.1/24"
  description = "The network space for service network gateway."
  type        = string
}
