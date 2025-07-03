variable "cluster_name" {
  description = "Cluster name"
  type        = string
}

variable "worker_nodes" {
  description = "Nummber of worker nodes to create"
  type        = number
  default     = 0
}

variable "worker_nodes_ipv4_prefix" {
  description = "IPv4 prefix for worker nodes"
  type        = string
}

variable "control_nodes" {
  description = "Nummber of control nodes to create"
  type        = number
  default     = 0
}

variable "control_nodes_ipv4_prefix" {
  description = "IPv4 prefix for control nodes"
  type        = string
}
