 env="dev"
 rg_name = "rg-terraform"
 vnet_name = "vnet-eastus-001"
 sg_name = "sg-eastus"
  st_name="steastussep302021"
  vm_user="testdevops1"
location="East US"
os = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04.0-LTS"
    version   = "latest"
}
osdisk = {
    name = "myosdisk"
    caching     = "ReadWrite"
    create_option       = "FromImage"  
    managed_disk_type="Standard_LRS" 
}
computer_name="testhost"
vmname="testvm"
private_subnet = ["10.4.0.0/29", "10.4.0.8/29"]
nsgrules=[80,443]
snets=2
nodes=2

