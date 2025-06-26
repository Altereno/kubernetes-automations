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
