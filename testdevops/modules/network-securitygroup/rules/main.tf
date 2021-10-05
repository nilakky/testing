resource "azurerm_network_security_rule" "sg" {
    name                       = var.sg_rule
    priority                   = var.priority
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name         = var.rgname
    network_security_group_name = var.sg_name  
}