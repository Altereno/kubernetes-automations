terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
    }
  }
}

resource "helm_release" "cilium" {
  name       = "cilium-cni"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  version    = "1.17.5"
  namespace  = "kube-system"

  values = [file("${path.module}/configs/cilium.yaml")]
}