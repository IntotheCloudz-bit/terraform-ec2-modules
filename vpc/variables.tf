
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
      var.availability_zones == null ||
      length(var.availability_zones) == 2
    )
    error_message = "Provide exactly two Availability Zones, or leave null for automatic selection."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR ranges for the two public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.3.0/24"]

  validation {
    condition     = length(var.public_subnet_cidrs) == 2
    error_message = "Provide exactly two public subnet CIDRs."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR ranges for the two private subnets"
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.4.0/24"]

  validation {
    condition     = length(var.private_subnet_cidrs) == 2
    error_message = "Provide exactly two private subnet CIDRs."
  }
}

variable "tags" {
  description = "Additional tags to apply to VPC resources"
  type        = map(string)
  default     = {}
}