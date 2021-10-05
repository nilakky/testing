resource "azurerm_subnet" "snet" {  
  name =var.snet_name
  resource_group_name =var.rgname
  virtual_network_name = var.vnetname
  address_prefixes = [var.ipaddress]
}
output "azurerm_subnet_out" {
    value = "${azurerm_subnet.snet.id}"
}