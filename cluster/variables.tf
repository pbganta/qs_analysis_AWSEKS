variable "env" {
  type        = string
  description = "name of the vpc to be created"
  default     = "stage"
}

variable "vpc_name" {
  type        = string
  description = "name of the vpc to be created"
  default     = "platformwale"
}

variable "cluster_name" {
  type        = string
  description = "eks cluster name"
}

variable "eks_version" {
  type        = string
  description = "kubernetes version"
  default     = "1.27"
}

variable "vpc_cidr" {
  type        = string
  description = "vpc cidr block to be used"
  default     = "10.0.0.0/16"
}

variable "newbits" {
  type        = number
  description = "split into 2^n parts, here 4"
  default     = 2
}

variable "netnum" {
  type        = number
  description = "enumerate throught subnets"
  default     = 4
}
