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
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.37.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.0.2"
    }
  }
  required_version = ">= 1.12.2"
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

provider "kubernetes" {
  config_path = "${path.root}/../.kube/config"
}

provider "helm" {
  kubernetes = {
    config_path = "${path.root}/../.kube/config"
  }
}

module "proxmox" {
  source = "./modules/proxmox"
}

module "talos" {
  source = "./modules/talos"

  worker_nodes               = module.proxmox.worker_nodes
  control_nodes              = module.proxmox.control_nodes
  worker_node_ips = module.proxmox.worker_node_ips
  control_node_ips = module.proxmox.control_node_ips
}
module "cilium" {
  source = "./modules/cilium"
}

module "longhorn" {
  source = "./modules/longhorn"
}