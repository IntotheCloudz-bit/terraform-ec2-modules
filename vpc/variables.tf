
variable "name" {
  description = "Project name prefix used for resource names"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR range for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Two Availability Zones to use; null selects two automatically"
  type        = list(string)
  default     = null

  validation {
    condition = (
      var.availability_zones == null
      ? true
      : length(var.availability_zones) == 2
    )

    error_message = "Provide exactly two Availability Zones, or leave null for automatic selection."
  }
}
variable "public_subnet_cidrs" {
  description = "Optional public subnet CIDRs; null calculates them automatically"
  type        = list(string)
  default     = null

  validation {
    condition     = var.public_subnet_cidrs == null ? true : length(var.public_subnet_cidrs) == 2
    error_message = "Provide exactly two public subnet CIDRs."
  }
}

variable "private_subnet_cidrs" {
  description = "Optional private subnet CIDRs; null calculates them automatically"
  type        = list(string)
  default     = null

  validation {
    condition     = var.private_subnet_cidrs == null ? true : length(var.private_subnet_cidrs) == 2
    error_message = "Provide exactly two private subnet CIDRs."
  }
}

variable "subnet_newbits" {
  description = "Additional network bits for subnet sizing; 8 converts /16 into /24"
  type        = number
  default     = 8

  validation {
    condition     = var.subnet_newbits >= 1 && var.subnet_newbits <= 12 && floor(var.subnet_newbits) == var.subnet_newbits
    error_message = "subnet_newbits must be an integer between 1 and 12."
  }
}

variable "tags" {
  description = "Tags applied to VPC resources"
  type        = map(string)
  default     = {}
}