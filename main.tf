terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.78.2"
    }
    talos = {
      source  = "siderolabs/talos"
      version = ">= 0.8.1"
    }
    null = {
      source = "hashicorp/null"
      version = ">= 3.2.4"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.0.2"
    }
  }
  required_version = ">= 1.12.2"
}

locals {
  kubeconfig_path  = "${path.root}/exported_configs/kubeconfig"
  talosconfig_path = "${path.root}/exported_configs/talosconfig"
}

provider "proxmox" {
  endpoint  = var.endpoint
  api_token = var.api_token
  ssh {
    agent    = true
    username = var.username
    password = var.password
  }
}

provider "helm" {
  kubernetes = {
    config_path = local.kubeconfig_path
  }
}

module "proxmox" {
  source = "./modules/proxmox"

  node_name          = var.node_name
  image_datastore_id = var.image_datastore_id
  vm_datastore_id    = var.vm_datastore_id

  talos_version   = var.talos_version
  talos_image_url = var.talos_image_url

  network_bridge_device = var.network_bridge_device
  ipv4_gateway          = var.ipv4_gateway
  dns_servers           = var.dns_servers

  control_nodes             = var.control_nodes
  control_nodes_cores       = var.control_nodes_cores
  control_nodes_ram_size    = var.control_nodes_ram_size
  control_nodes_disk_size   = var.control_nodes_disk_size
  control_nodes_ipv4_prefix = var.control_nodes_ipv4_prefix

  worker_nodes             = var.worker_nodes
  worker_nodes_cores       = var.worker_nodes_cores
  worker_nodes_ram_size    = var.worker_nodes_ram_size
  worker_nodes_disk_size   = var.worker_nodes_disk_size
  worker_nodes_ipv4_prefix = var.worker_nodes_ipv4_prefix
}

module "talos" {
  depends_on = [module.proxmox]

  source = "./modules/talos"

  cluster_name              = var.cluster_name
  control_nodes             = var.control_nodes
  control_nodes_ipv4_prefix = var.control_nodes_ipv4_prefix
  worker_nodes              = var.worker_nodes
  worker_nodes_ipv4_prefix  = var.worker_nodes_ipv4_prefix
}

module "cilium" {
  depends_on = [module.talos]

  source = "./modules/cilium"
}

module "longhorn" {
  depends_on = [module.talos]

  source = "./modules/longhorn"
}
