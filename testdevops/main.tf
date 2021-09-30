
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
  address_space = ["10.10.0.0/24"]

  tags = {
    environment = var.env
  }
}
resource "azurerm_subnet" "snet1" {
  name = "${var.snet_name_0}-${var.env}"
  resource_group_name = azurerm_resource_group.rgp.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = ["10.10.0.0/25"] 
}
resource "azurerm_subnet" "snet2" {
  name = "${var.snet_name_1}-${var.env}"
  resource_group_name = azurerm_resource_group.rgp.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = ["10.10.0.128/28"]
}

#Network security group
resource "azurerm_network_security_group" "sg" {
  name                = "${var.sg_name}-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rgp.name

  security_rule {
    name                       = "${var.sg_rule_80}-${var.env}"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
   security_rule {
    name                       = "${var.sg_rule_443}-${var.env}"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.env
  }
}

#Virtual Machine 1
resource "azurerm_network_interface" "nic1" {
  name                = "${var.nic_001}-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rgp.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.snet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm1" {
  name                  = "vm001-${var.env}"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rgp.name
  network_interface_ids = [azurerm_network_interface.nic1.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = var.os.publisher
    offer     = var.os.offer
    sku       = var.os.sku
    version   = var.os.version
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "testhost"
    admin_username = var.vm_user
    admin_password = var.vm_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "${var.env}"
  }
}



#Virtual Machine 2
resource "azurerm_network_interface" "nic2" {
  name                = "${var.nic_002}-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rgp.name

  ip_configuration {
    name                          = "testconfiguration2"
    subnet_id                     = azurerm_subnet.snet2.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm2" {
  name                  = "vm002-${var.env}"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rgp.name
  network_interface_ids = [azurerm_network_interface.nic2.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = var.os.publisher
    offer     = var.os.offer
    sku       = var.os.sku
    version   = var.os.version
  }
  storage_os_disk {
    name              = "myosdisk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = lookup(var.managed_disk_type, var.location, "Standard_LRS")
  }
  os_profile {
    computer_name  = "testhost1"
    admin_username = var.vm_user
    admin_password = var.vm_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = var.env
  }
}

#Storage account creation

resource "azurerm_storage_account" "st" {
  name                     = var.st_name
  resource_group_name      = azurerm_resource_group.rgp.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = var.env
  }
}