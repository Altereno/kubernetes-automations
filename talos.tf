locals {
  worker_node_ips  = [for i in range(var.worker_nodes) : "${cidrhost(var.worker_nodes_ipv4_prefix, i)}"]
  control_node_ips = [for i in range(var.control_nodes) : "${cidrhost(var.control_nodes_ipv4_prefix, i)}"]
}

resource "talos_machine_secrets" "this" {}

data "talos_machine_configuration" "worker" {
  cluster_name     = var.cluster_name
  machine_type     = "worker"
  cluster_endpoint = "https://${cidrhost(var.worker_nodes_ipv4_prefix, var.control_nodes)}:6443"
  machine_secrets  = talos_machine_secrets.this.machine_secrets
}

data "talos_machine_configuration" "controlplane" {
  cluster_name     = var.cluster_name
  machine_type     = "controlplane"
  cluster_endpoint = "https://${cidrhost(var.worker_nodes_ipv4_prefix, var.control_nodes)}:6443"
  machine_secrets  = talos_machine_secrets.this.machine_secrets
}

data "talos_client_configuration" "this" {
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.this.client_configuration
  nodes                = concat(local.control_node_ips, local.worker_node_ips)
}

resource "talos_machine_configuration_apply" "worker" {
  depends_on = [proxmox_virtual_environment_vm.worker-nodes]

  for_each = toset(local.worker_node_ips)

  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.worker.machine_configuration
  node                        = each.value
  config_patches = [
    yamlencode({
      machine = {
        kubelet = {
          extraMounts = [
            {
              destination = "/var/lib/longhorn"
              type        = "bind"
              source      = "/var/lib/longhorn"
              options = [
                "bind",
                "rshared",
                "rq"
              ]
            }
          ]
        }
        install = {
          disk = "/dev/vda"
        }
      }
      cluster = {
        network = {
          cni = {
            name = "none"
          }
        }
        proxy = {
          disabled = true
        }
      }
    })
  ]
}

resource "talos_machine_configuration_apply" "controlplane" {
  depends_on = [proxmox_virtual_environment_vm.control-nodes]

  for_each = toset(local.control_node_ips)

  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.controlplane.machine_configuration
  node                        = each.value
  config_patches = [
    yamlencode({
      machine = {
        kubelet = {
          extraMounts = [
            {
              destination = "/var/lib/longhorn"
              type        = "bind"
              source      = "/var/lib/longhorn"
              options = [
                "bind",
                "rshared",
                "rq"
              ]
            }
          ]
        }
        install = {
          disk = "/dev/vda"
        }
        network = {
          interfaces = [
            {
              interface = "eth0"
              vip = {
                ip = "${cidrhost(var.worker_nodes_ipv4_prefix, var.control_nodes)}"
              }
            }
          ]
        }
      }
      cluster = {
        network = {
          cni = {
            name = "none"
          }
        }
        proxy = {
          disabled = true
        }
      }
    })
  ]
}

resource "talos_machine_bootstrap" "this" {
  depends_on           = [talos_machine_configuration_apply.controlplane, talos_machine_configuration_apply.worker]
  node                 = cidrhost(var.control_nodes_ipv4_prefix, 0)
  client_configuration = talos_machine_secrets.this.client_configuration
}

resource "talos_cluster_kubeconfig" "this" {
  depends_on           = [talos_machine_bootstrap.this]
  node                 = cidrhost(var.control_nodes_ipv4_prefix, 0)
  client_configuration = talos_machine_secrets.this.client_configuration
}
