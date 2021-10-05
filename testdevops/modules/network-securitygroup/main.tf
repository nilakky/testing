resource "azurerm_network_security_group" "sg" {
  name                = var.sg_name
  location            = var.location
  resource_group_name = var.rgname  

  tags = {
    environment = var.env
  }
}