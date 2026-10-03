variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "Two Availability Zones for the VPC subnets. Uses the first two available AZs if null."
  type        = list(string)
  default     = null

  validation {
    condition     = var.availability_zones == null || length(var.availability_zones) == 2
    error_message = "Provide exactly two Availability Zones, or leave this null."
  }
}