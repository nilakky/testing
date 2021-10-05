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

variable "managed_disk_type" { 
    type = map
    description = "Disk type Premium in Primary location Standard in DR location"

    default = {
        westus2 = "Premium_LRS"
        eastus = "Standard_LRS"
    }
}
variable "vmname" {
    type =string
    description = "Virtual machine name"
  
}

variable "rgname" {
    type = string
    description = "Name of resource group"
}
variable "env" {
    type = string
    description = "Environment name"
}
variable "location" {
    type = string
    description = "Azure location of storage account environment"
    default = "eastus"
}

/*variable "nicid" {
    type = list(string)
    description = "NIC id"    
} */  
variable "vm_size" {
    type = string
    description = "VM size"
    default = "Standard_DS1_v2"
}  
variable "computer_name" {
    type = string
    description = "Computer name"
}  
variable "nicname" {
  type = string
  description = "Network interface name"
}
variable "subnet_id" {
    type = string
    description = "Subnet id"
  
}