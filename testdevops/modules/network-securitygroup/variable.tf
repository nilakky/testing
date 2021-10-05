variable "rgname" {
    type = string
    description = "Name of resource group"
}
variable "location" {
  type=string
  description="snet IP address"
}
variable "sg_name" {
  type=string
  description = "Network Security Group"
}
variable "env" {
  type=string
  description = "Environment"
}