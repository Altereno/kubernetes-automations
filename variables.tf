variable "endpoint" {
  description = "Endpoint for Proxmox host"
  type        = string
}

variable "api_token" {
  description = "API token for proxmox user"
  type        = string
  sensitive   = true
}

variable "username" {
  description = "PVE User"
  type        = string
}

variable "password" {
  description = "PVE User password"
  type        = string
  sensitive   = true
}
