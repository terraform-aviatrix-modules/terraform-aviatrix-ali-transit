variable "region" {
  description = "The ALI region to deploy this module in"
  type        = string
}

variable "cidr" {
  description = "The CIDR range to be used for the VPC"
  type        = string
}

variable "account" {
  description = "The ALI account name, as known by the Aviatrix controller"
  type        = string
}

variable "instance_size" {
  description = "ALI Instance size for the Aviatrix gateways"
  type        = string
  default     = "ecs.g5ne.large"
}

variable "ha_gw" {
  description = "Boolean to determine if module will be deployed in HA or single mode"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name for this spoke VPC and it's gateways"
  type        = string
  default     = ""
}

variable "prefix" {
  description = "Boolean to determine if name will be prepended with avx-"
  type        = bool
  default     = true
}

variable "suffix" {
  description = "Boolean to determine if name will be appended with -spoke"
  type        = bool
  default     = true
}

variable "connected_transit" {
  description = "Set to false to disable connected transit."
  type        = bool
  default     = true
}

variable "bgp_manual_spoke_advertise_cidrs" {
  description = "Define a list of CIDRs that should be advertised via BGP."
  type        = string
  default     = ""
}

variable "learned_cidr_approval" {
  description = "Set to true to enable learned CIDR approval."
  type        = string
  default     = "false"
}

variable "active_mesh" {
  description = "Set to false to disable active mesh."
  type        = bool
  default     = true
}

variable "enable_segmentation" {
  description = "Switch to true to enable transit segmentation"
  type        = bool
  default     = false
}

variable "single_az_ha" {
  description = "Set to true if Controller managed Gateway HA is desired"
  type        = bool
  default     = true
}

variable "single_ip_snat" {
  description = "Enable single_ip mode Source NAT for this container"
  type        = bool
  default     = false
}

variable "enable_advertise_transit_cidr" {
  description = "Switch to enable/disable advertise transit VPC network CIDR for a VGW connection"
  type        = bool
  default     = false
}

variable "bgp_polling_time" {
  description = "BGP route polling time. Unit is in seconds"
  type        = string
  default     = "50"
}

variable "bgp_ecmp" {
  description = "Enable Equal Cost Multi Path (ECMP) routing for the next hop"
  type        = bool
  default     = false
}

variable "local_as_number" {
  description = "Changes the Aviatrix Transit Gateway ASN number before you setup Aviatrix Transit Gateway connection configurations."
  type        = string
  default     = null
}

variable "tunnel_detection_time" {
  description = "The IPsec tunnel down detection time for the Spoke Gateway in seconds. Must be a number in the range [20-600]."
  type        = number
  default     = null
}

variable "enable_multi_tier_transit" {
  description = "Set to true to enable multi tier transit."
  type        = bool
  default     = false
}

variable "learned_cidrs_approval_mode" {
  description = "Learned cidrs approval mode. Defaults to Gateway. Valid values: gateway, connection"
  type        = string
  default     = null
}

locals {
  region_name = join("-", slice(split(" ", var.region), 1, -1))
  lower_name  = length(var.name) > 0 ? replace(lower(var.name), " ", "-") : replace(lower(local.region_name), " ", "-")
  prefix      = var.prefix ? "avx-" : ""
  suffix      = var.suffix ? "-transit" : ""
  name        = "${local.prefix}${local.lower_name}${local.suffix}"
  subnet      = aviatrix_vpc.default.public_subnets[0].cidr
  ha_subnet   = aviatrix_vpc.default.public_subnets[2].cidr
}
