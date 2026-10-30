variable "name" {
  description = "RDS identifier, using lowercase letters, numbers, and hyphens"
  type        = string
}

variable "database_name" {
  description = "Initial MySQL database name"
  type        = string
  default     = "buildops"
}

variable "master_username" {
  description = "Database administrator username"
  type        = string
  default     = "buildopsadmin"
}

variable "engine_version" {
  description = "Supported RDS MySQL version to deploy"
  type        = string
}

variable "instance_class" {
  description = "RDS database instance class"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs spanning at least two Availability Zones"
  type        = list(string)

  validation {
    condition     = length(distinct(var.subnet_ids)) >= 2
    error_message = "Provide at least two different private subnet IDs."
  }
}

variable "security_group_ids" {
  description = "Security groups controlling access to the database"
  type        = list(string)

  validation {
    condition     = length(var.security_group_ids) > 0
    error_message = "Provide at least one database security group."
  }
}

variable "allocated_storage" {
  description = "Initial storage capacity in GiB"
  type        = number
  default     = 20
}

variable "multi_az" {
  description = "Enable a standby database in another Availability Zone"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Number of days to retain automated backups"
  type        = number
  default     = 7

  validation {
    condition = (
      var.backup_retention_period >= 1 &&
      var.backup_retention_period <= 35
    )
    error_message = "Backup retention must be between 1 and 35 days."
  }
}

variable "deletion_protection" {
  description = "Block database deletion until explicitly disabled"
  type        = bool
  default     = true
}

variable "final_snapshot_identifier" {
  description = "Unique name for the final snapshot taken when deleting the database"
  type        = string
}

variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
  default     = {}
}