terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
    }
  }
}

resource "helm_release" "longhorn" {
  name             = "longhorn-csi"
  repository       = "https://charts.longhorn.io"
  chart            = "longhorn"
  version          = "1.8.2"
  namespace        = "longhorn-system"
  create_namespace = true
}
