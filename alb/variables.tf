variable "name" {
  description = "Short name prefix for the ALB and target group"
  type        = string

  validation {
    condition = (
      length(var.name) <= 28 &&
      can(regex("^[a-z][a-z0-9-]*[a-z0-9]$", var.name))
    )
    error_message = "Use 2–28 lowercase letters, numbers, or hyphens; start with a letter and end with a letter or number."
  }
}

variable "vpc_id" {
  description = "VPC containing the application targets"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs spanning at least two Availability Zones"
  type        = list(string)

  validation {
    condition     = length(distinct(var.public_subnet_ids)) >= 2
    error_message = "Provide at least two different public subnet IDs."
  }
}

variable "security_group_ids" {
  description = "Security groups attached to the ALB"
  type        = list(string)

  validation {
    condition     = length(var.security_group_ids) > 0
    error_message = "Provide at least one ALB security group."
  }
}

variable "application_port" {
  description = "Port on which the application listens"
  type        = number
  default     = 8080

  validation {
    condition = (
      var.application_port >= 1 &&
      var.application_port <= 65535 &&
      floor(var.application_port) == var.application_port
    )
    error_message = "Application port must be a whole number from 1 to 65535."
  }
}

variable "health_check_path" {
  description = "Application endpoint used for target health checks"
  type        = string
  default     = "/health"

  validation {
    condition     = startswith(var.health_check_path, "/")
    error_message = "The health-check path must start with /."
  }
}

variable "deletion_protection" {
  description = "Prevent accidental ALB deletion when enabled"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
  default     = {}
}