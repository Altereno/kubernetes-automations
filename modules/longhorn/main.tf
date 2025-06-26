# resource "helm_release" "longhorn" {
#   name             = "longhorn-csi"
#   repository       = "https://charts.longhorn.io"
#   chart            = "longhorn"
#   version          = "1.8.2"
#   create_namespace = true
#   namespace        = "longhorn-system"
# }
