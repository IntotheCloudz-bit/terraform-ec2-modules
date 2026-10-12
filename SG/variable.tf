
variable "name" {
  description = "Name prefix for the security group"
  type        = string
}

variable "description" {
  description = "Description of the security group's purpose"
  type        = string
  default     = "Managed by Terraform"
}

variable "vpc_id" {
  description = "ID of the VPC where the security group will be created"
  type        = string
}

variable "ingress_rules" {
  description = "List of inbound rules to allow"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

variable "egress_rules" {
  description = "List of outbound rules to allow"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
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
  description = "Additional tags to apply to the security group"
  type        = map(string)
  default     = {}
}