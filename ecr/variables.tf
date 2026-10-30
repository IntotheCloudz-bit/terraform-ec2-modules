variable "repository_name" {
  description = "Name of the private ECR repository"
  type        = string
}

variable "untagged_image_retention_days" {
  description = "Expire untagged images older than this many days since push"
  type        = number
  default     = 14

  validation {
    condition = (
      var.untagged_image_retention_days >= 1 &&
      floor(var.untagged_image_retention_days) == var.untagged_image_retention_days
    )
    error_message = "Retention must be a positive whole number of days."
  }
}

variable "force_delete" {
  description = "Allow repository deletion even when it contains images"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags for the repository"
  type        = map(string)
  default     = {}
}