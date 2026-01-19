variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0f5ee92e2d63afc18"  # Amazon Linux 2 in ap-south-1
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 8
}

variable "assign_public_ip" {
  description = "Assign public IP to instances"
  type        = bool
  default     = true
}

variable "enable_auto_scaling" {
  description = "Enable auto scaling"
  type        = bool
  default     = false
}

variable "min_size" {
  description = "Minimum size for auto scaling group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum size for auto scaling group"
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "Desired capacity for auto scaling group"
  type        = number
  default     = 2
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}
