variable "name" {
  description = "Name prefix for ECS resources"
  type        = string
}

variable "image_uri" {
  description = "Full container image URI with a unique tag or digest"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private application subnets for Fargate tasks"
  type        = list(string)

  validation {
    condition     = length(distinct(var.private_subnet_ids)) >= 2
    error_message = "Provide at least two distinct private subnet IDs."
  }
}

variable "security_group_ids" {
  description = "Security groups attached to the application tasks"
  type        = list(string)

  validation {
    condition     = length(var.security_group_ids) > 0
    error_message = "Provide at least one application security group."
  }
}

variable "target_group_arn" {
  description = "ARN of the ALB IP target group"
  type        = string
}

variable "container_port" {
  description = "Port on which the application listens"
  type        = number
  default     = 8080
}

variable "desired_count" {
  description = "Number of application tasks to keep running"
  type        = number
  default     = 1

  validation {
    condition = (
      var.desired_count >= 0 &&
      floor(var.desired_count) == var.desired_count
    )
    error_message = "Desired count must be a nonnegative whole number."
  }
}

variable "environment_variables" {
  description = "Non-secret application environment variables"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
  default     = {}
}