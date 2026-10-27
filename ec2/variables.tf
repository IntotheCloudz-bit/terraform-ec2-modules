
variable "ami_id" {
  description = "AMI ID. Leave null to use the default Ubuntu 24.04 LTS AMI."
  type        = string
  default     = null
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "name" {
  description = "Name tag for the EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will launch"
  type        = string
}

variable "security_group_ids" {
  description = "Security group IDs attached to the instance"
  type        = list(string)
}

variable "key_name" {
  description = "Optional name of an existing EC2 key pair"
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  description = "Whether to assign a public IPv4 address to the instance"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags to apply to the EC2 instance"
  type        = map(string)
  default     = {}
}

variable "iam_instance_profile_name" {
  description = "Existing IAM instance profile to attach to EC2"
  type        = string
  default     = null
}