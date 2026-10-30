variable "name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "EKS Kubernetes version selected for deployment"
  type        = string
}

variable "vpc_id" {
  description = "VPC containing the EKS cluster networking"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnets for EKS, spanning at least two AZs"
  type        = list(string)

  validation {
    condition     = length(distinct(var.private_subnet_ids)) >= 2
    error_message = "Provide at least two distinct private subnet IDs."
  }
}

variable "node_instance_types" {
  description = "EC2 instance types for the managed worker nodes"
  type        = list(string)

  validation {
    condition     = length(var.node_instance_types) > 0
    error_message = "Provide at least one worker instance type."
  }
}

variable "node_scaling" {
  description = "Minimum, desired, and maximum worker-node counts"

  type = object({
    min     = number
    desired = number
    max     = number
  })

  default = {
    min     = 1
    desired = 2
    max     = 3
  }

  validation {
    condition = (
      var.node_scaling.min >= 0 &&
      var.node_scaling.max >= 1 &&
      var.node_scaling.min <= var.node_scaling.desired &&
      var.node_scaling.desired <= var.node_scaling.max &&
      alltrue([
        for count in [
          var.node_scaling.min,
          var.node_scaling.desired,
          var.node_scaling.max
        ] : floor(count) == count
      ])
    )

    error_message = "Use whole-number counts with 0 <= min <= desired <= max and max >= 1."
  }
}

variable "admin_principal_arn" {
  description = "IAM role or user ARN that receives cluster administrator access"
  type        = string
}

variable "public_access_cidrs" {
  description = "Trusted IPv4 CIDRs allowed to reach the public Kubernetes API endpoint"
  type        = list(string)

  validation {
    condition = (
      length(var.public_access_cidrs) > 0 &&
      alltrue([
        for cidr in var.public_access_cidrs :
        can(cidrnetmask(cidr))
      ])
    )

    error_message = "Provide at least one valid IPv4 CIDR."
  }
}

variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
  default     = {}
}

variable "log_retention_days" {
  description = "Retention period for EKS control plane logs"
  type        = number
  default     = 90

  validation {
    condition = contains(
      [1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365],
      var.log_retention_days
    )
    error_message = "Select a supported CloudWatch retention period."
  }
}

variable "enable_deletion_protection" {
  description = "Protect the EKS cluster against accidental deletion"
  type        = bool
  default     = true
}