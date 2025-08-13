variable "driver" {
  description = "Enter Minikube driver"
  type        = string
  default     = "docker"
}

variable "memory" {
  description = "amount of ram for minikube"
  type        = string
  default     = "3913"
}

variable "cpus" {
  description = "Number of cpus to be used"
  type        = string
  default     = "2"
}
