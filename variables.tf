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

variable "node_name" {
  description = "Proxmox node name"
  type        = string
}

variable "image_datastore_id" {
  description = "Image download datastore location"
  type        = string
}

variable "vm_datastore_id" {
  description = "VM image datastore location"
  type        = string
}

variable "talos_version" {
  description = "Version of Talos Linux being deploy, for naming purposes"
  type        = string
}

variable "talos_image_url" {
  description = "Download link of the image file, not iso of Talos Linux"
  type        = string
}

variable "network_bridge_device" {
  description = "Network bridge device for nodes"
  type        = string
}

variable "ipv4_gateway" {
  description = "Default gateway for nodes"
  type        = string
}

variable "dns_servers" {
  description = "DNS server for nodes"
  type        = list(string)
}

variable "control_nodes" {
  description = "Nummber of control nodes to create"
  type        = number
  default     = 0
}

variable "control_nodes_cores" {
  description = "Number of cores for each control node"
  type        = number
  default     = 2
}

variable "control_nodes_ram_size" {
  description = "Size in MB for control node RAM"
  type        = number
  default     = 2048
}

variable "control_nodes_disk_size" {
  description = "VM disk size"
  type        = number
  default     = 10
}

variable "control_nodes_ipv4_prefix" {
  description = "IPv4 prefix for control nodes"
  type        = string
}

variable "worker_nodes" {
  description = "Nummber of worker nodes to create"
  type        = number
  default     = 0
}

variable "worker_nodes_cores" {
  description = "Number of cores for each worker node"
  type        = number
  default     = 1
}

variable "worker_nodes_ram_size" {
  description = "Size in MB for worker node RAM"
  type        = number
  default     = 1024
}

variable "worker_nodes_disk_size" {
  description = "VM disk size"
  type        = number
  default     = 10
}

variable "worker_nodes_ipv4_prefix" {
  description = "IPv4 prefix for worker nodes"
  type        = string
}

variable "cluster_name" {
  description = "Cluster name"
  type        = string
}
