# Module Aviatrix Transit VPC for Alibaba Cloud

### Description
This module deploys a VPC and a set of Aviatrix transit gateways.

### Diagram
<img src="https://github.com/terraform-aviatrix-modules/terraform-aviatrix-ali-transit/blob/master/img/transit-vpc-ali-ha.png?raw=true">

with ha_gw set to false, the following will be deployed:

<img src="https://github.com/terraform-aviatrix-modules/terraform-aviatrix-ali-transit/blob/master/img/transit-vpc-ali.png?raw=true">

### Compatibility
Module version | Terraform version | Controller version | Terraform provider version
:--- | :--- | :--- | :---
v4.0.0 | 0.13-0.15 | >=6.4 | >=0.2.19

### Usage Example
```
module "transit_ali_1" {
  source  = "terraform-aviatrix-modules/ali-transit/aviatrix"
  version = "4.0.0"

  cidr    = "10.1.0.0/20"
  region  = "acs-us-west-1 (Silicon Valley)"
  account = "ALI"
}
```

### Variables
The following variables are required:

key | value
:--- | :---
region | Alibaba region to deploy the transit VPC in
account | The Alibaba accountname on the Aviatrix controller, under which the controller will deploy this VPC
cidr | The IP CIDR wo be used to create the VPC.

The following variables are optional:

key | default | value
--- | --- | ---
name | avx-\<region\>-transit | Provide a custom name for VPC and Gateway resources. Result will be avx-\<name\>-transit.
instance_size | ecs.g5ne.large | Size of the transit gateway instances
ha_gw | true | Set to true to false te deploy a single transit GW.
connected_transit | true | Set to false to disable connected_transit
bgp_manual_spoke_advertise_cidrs | | Intended CIDR list to advertise via BGP. Example: "10.2.0.0/16,10.4.0.0/16" 
learned_cidr_approval | false | Switch to true to enable learned CIDR approval
active_mesh | true | Set to false to disable active_mesh
prefix | true | Boolean to enable prefix name with avx-
suffix | true | Boolean to enable suffix name with -transit
enable_segmentation | false | Switch to true to enable transit segmentation
single_az_ha | true | Set to false if Controller managed Gateway HA is desired
single_ip_snat | false | Enable single_ip mode Source NAT for this container
enable_advertise_transit_cidr  | false | Switch to enable/disable advertise transit VPC network CIDR for a VGW connection
bgp_polling_time  | 50 | BGP route polling time. Unit is in seconds
bgp_ecmp  | false | Enable Equal Cost Multi Path (ECMP) routing for the next hop
local_as_number | | Changes the Aviatrix Transit Gateway ASN number before you setup Aviatrix Transit Gateway connection configurations.
tunnel_detection_time | null | The IPsec tunnel down detection time for the Spoke Gateway in seconds. Must be a number in the range [20-600]. Default is 60.
enable_multi_tier_transit |	false |	Switch to enable multi tier transit
learned_cidrs_approval_mode | | Learned cidrs approval mode. Defaults to Gateway. Valid values: gateway, connection

### Outputs
This module will return the following objects:

key | description
--- | ---
[vpc](https://registry.terraform.io/providers/AviatrixSystems/aviatrix/latest/docs/resources/aviatrix_vpc) | The created VPC as an object with all of it's attributes. This was created using the aviatrix_vpc resource.
[transit_gateway](https://registry.terraform.io/providers/AviatrixSystems/aviatrix/latest/docs/resources/aviatrix_transit_gateway) | The created Aviatrix transit gateway as an object with all of it's attributes.
