resource "helm_release" "cilium" {
  name       = "cilium-cni"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  version    = "1.17.5"
  namespace  = "kube-system"

  set = [
    {
      name  = "ipam.mode"
      value = "kubernetes"
    },

    {
      name  = "kubeProxyReplacement"
      value = "true"
    },

    {
      name  = "securityContext.capabilities.ciliumAgent"
      value = "{CHOWN,KILL,NET_ADMIN,NET_RAW,IPC_LOCK,SYS_ADMIN,SYS_RESOURCE,DAC_OVERRIDE,FOWNER,SETGID,SETUID}"
    },

    {
      name  = "securityContext.capabilities.cleanCiliumState"
      value = "{NET_ADMIN,SYS_ADMIN,SYS_RESOURCE}"
    },

    {
      name  = "cgroup.autoMount.enabled"
      value = "false"
    },

    {
      name  = "cgroup.hostRoot"
      value = "/sys/fs/cgroup"
    },

    {
      name  = "k8sServiceHost"
      value = "localhost"
    },

    {
      name  = "k8sServicePort"
      value = "7445"
    },
    {
      name  = "gatewayAPI.enabled"
      value = "true"
    },
    {
      name  = "gatewayAPI.enableAlpn"
      value = "true"
    },
    {
      name  = "gatewayAPI.enableAppProtocol"
      value = "true"
    }
  ]
}

resource "helm_release" "cilium" {
  name             = "longhorn-csi"
  repository       = "https://charts.longhorn.io"
  chart            = "longhorn"
  version          = "1.8.2"
  create_namespace = true
  namespace        = "longhorn-system"
}
