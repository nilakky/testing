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
variable "sg_name" {
  type = string
  description = "Network security group name"
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
variable "osdisk" {
    description = "Operating system disk"
    type = object({
        name = string
        caching = string
        create_option = string     
         managed_disk_type=string   
  })
} 
variable "vm_size" {
    type = string
    description = "VM size"
    default = "Standard_DS1_v2"
}  
variable "private_subnet" {
  type    = list(string)
  default = []
}
variable "nodes" {
  type  =number
  default=1
  description = "Number of nodes"
}
variable "snets" {
  type=number
  default=1
  description = "Number of sub nets"
}
variable "nsgrules" {
  type    = list(number)
  default = [80]
}
