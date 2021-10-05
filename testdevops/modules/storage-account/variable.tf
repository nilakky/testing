variable "stname" {
    type = string
    description = "Name of storage account"
}
variable "rgname" {
    type = string
    description = "Name of resource group"
}
variable "env" {
    type = string
    description = "Name of resource group"
}
variable "location" {
    type = string
    description = "Azure location of storage account environment"
    default = "eastus"
}
