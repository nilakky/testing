variable "env" {
  type = string
  description = "Environment to configure infrastructure"
}
variable "rg_name" {
  type = string
  description = "Resource group name"
}
variable "location" {
  type = string
  description = "Location to deploy resources"
}
variable "vnet_name" {
  type = string
  description = "Virtual network name"
}

variable "snet_name_0" {
  type = string
  description = "Subnet name 1"
}

variable "snet_name_1" {
  type = string
  description = "Subnet name 2"
}

variable "sg_name" {
  type = string
  description = "Network security group name"
}
variable "sg_rule_80" {
  type = string
  description = "Network security rule for 80 port"
}
variable "sg_rule_443" {
  type = string
  description = "Network security rule for 443 port"
}

variable "nic_001" {
  type = string
  description = "Network interface 1"
}
variable "nic_002" {
  type = string
  description = "Network interface 2"
}

variable "st_name" {
  type = string
  description = "Storage account name"
}

variable "vm_user" {
  type = string
  description = "Administrator username for server"
}
variable "vm_pwd" {
    type = string
    description = "Administrator password for server"
}

variable "os" {
    description = "Operating system to display"
    type = object({
        publisher = string
        offer = string
        sku = string
        version = string
  })
}   

variable "managed_disk_type" { 
    type = map
    description = "Disk type Premium in Primary location Standard in DR location"

    default = {
        westus2 = "Premium_LRS"
        eastus = "Standard_LRS"
    }
}