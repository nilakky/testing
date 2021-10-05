variable "vnetname" {
    type = string
    description = "Virtual network name"
}
variable "rgname" {
    type = string
    description = "Name of resource group"
}
variable "snet_name" {
    type = string
    description = "subnet name"
}
variable "ipaddress" {
  type=string
  description="snet IP address"
}
