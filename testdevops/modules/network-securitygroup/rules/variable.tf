variable "rgname" {
    type = string
    description = "Name of resource group"
}

variable "env" {
  type=string
  description="Environment"
}
variable "sg_name" {
  type=string
  description = "Network Security Group"
}
variable "sg_rule" {
  type = string
  description = "Network security group rule"
}
variable "port" {
  type = number
  description = "Security group port number"
}
variable "priority" {
    type = number
    description = "Security group priority rule"  
}