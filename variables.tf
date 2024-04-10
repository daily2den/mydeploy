variable "mgmt_cidr_blocks" {
  description = "A list of CIDR blocks to allow management access from"
  default     = []
  type        = list
}
