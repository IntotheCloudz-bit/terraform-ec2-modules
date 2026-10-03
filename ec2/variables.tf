```hcl
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
  description = "Name of the existing EC2 key pair"
  type        = string
}
```
