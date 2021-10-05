resource "azurerm_network_interface" "nic" {
  name                = var.nicname
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.vmname}-${var.env}"
  location              = var.location
  resource_group_name   = var.rgname
  network_interface_ids =[azurerm_network_interface.nic.id]
  vm_size               = var.vm_size

  storage_image_reference {
    publisher = var.os.publisher
    offer     = var.os.offer
    sku       = var.os.sku
    version   = var.os.version
  }
  storage_os_disk {
    name              = var.osdisk.name
    caching           = var.osdisk.caching
    create_option     = var.osdisk.create_option
    managed_disk_type = lookup(var.managed_disk_type, var.location, "Standard_LRS")
  }
  os_profile {
    computer_name  = var.computer_name
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

