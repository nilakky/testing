terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.78.0"
    }
  }
   backend "azurerm" {
    storage_account_name = "test"
    container_name       = "test"
    key                  = "terraform.tfstate"    
    access_key = "key"
  }
}
provider "azurerm" {    
  features {} 
}
resource "azurerm_resource_group" "rgp" {
  name     = "${var.rg_name}-${var.env}"
  location = var.location
  tags = {
    environment = var.env
  }
}

# Create a vnet within the resource group
resource "azurerm_virtual_network" "vnet" {
  name = "${var.vnet_name}-${var.env}"
  resource_group_name = azurerm_resource_group.rgp.name
  location = var.location
  address_space = ["10.4.0.0/24"]

  tags = {
    environment = var.env
  }
}
//Create subnet
module "subnet" {
  source="./modules/subnet"
   count  = var.snets
   snet_name = "snet${format("%02d", count.index)}-${var.env}"
  rgname = azurerm_resource_group.rgp.name
  vnetname = azurerm_virtual_network.vnet.name
  ipaddress = var.private_subnet[count.index]
}

//Create Virtual Machine
module "virtual_machine" {
  source                 = "./modules/virtual-machine"
  count  = var.nodes
  vmname                   = "vm${format("%02d", count.index)}"
  rgname    = azurerm_resource_group.rgp.name
  vm_size                = var.vm_size
  os=var.os
  osdisk={name="disk${format("%02d", count.index)}"
   caching     = var.osdisk.caching
    create_option       = var.osdisk.create_option
    managed_disk_type=var.osdisk.managed_disk_type
  }
    computer_name  = "vm-${format("%02d", count.index)}"
    vm_user = var.vm_user
    vm_pwd = var.vm_pwd
    env  = var.env
  location=var.location
  nicname=  "nic${format("%02d", count.index)}-${var.env}"
  subnet_id="${module.subnet[count.index].azurerm_subnet_out}"
}

//Create network security group
module "network_securitygroup"{
  source="./modules/network-securitygroup"
  sg_name=var.sg_name
  env=var.env
  location=var.location
  rgname=azurerm_resource_group.rgp.name
}
module "network_securitygroup_rule"{
  count="${length(var.nsgrules)}"
  source="./modules/network-securitygroup/rules" 
  sg_rule                       = "sgrule${format("%02d", count.index)}"
  port=var.nsgrules[count.index]
  priority= (100 * (count.index + 1))
  env                   = var.env
  rgname=azurerm_resource_group.rgp.name
  sg_name=var.sg_name
}
#Storage account creation
module "storage_account" {
  source    = "./modules/storage-account"
  stname    = var.st_name
  rgname    = azurerm_resource_group.rgp.name
  location  = azurerm_resource_group.rgp.location
  env=var.env
}
