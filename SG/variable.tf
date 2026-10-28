
variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Purpose of the security group"
  type        = string
  default     = "Managed by Terraform"
}

variable "vpc_id" {
  description = "VPC where the security group is created"
  type        = string
}

variable "ingress_rules" {
  description = "Inbound traffic rules"

  type = list(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string), [])
    security_groups = optional(list(string), [])
  }))

  default = []
}

variable "egress_rules" {
  description = "Outbound traffic rules"

  type = list(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string), [])
    security_groups = optional(list(string), [])
  }))

  default = [
    {
      description = "Allow all outbound IPv4 traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
