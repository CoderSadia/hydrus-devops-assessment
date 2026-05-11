variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "hydrus"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "eks_node_count" {
  description = "Number of EKS nodes"
  type        = number
  default     = 2
}

variable "eks_node_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}
