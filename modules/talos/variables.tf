variable "cluster_name" {
  description = "Cluster name"
  type        = string
}

variable "worker_nodes" {
  description = "Imported from proxmox module"
  type        = number
}

variable "worker_nodes_ipv4_prefix" {
  description = "Imported from proxmox module"
  type        = string
}

variable "control_nodes" {
  description = "Imported from proxmox module"
  type        = number
}

variable "control_nodes_ipv4_prefix" {
  description = "Imported from proxmox module"
  type        = string
}
