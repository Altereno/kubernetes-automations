resource "proxmox_virtual_environment_download_file" "talos_linux_image" {
    node_name = var.node_name
    content_type = "iso"
    datastore_id = var.image_datastore_id
    file_name = "talos-${var.talos_version}-nocloud-amd64.iso"
    url = var.talos_image_url
    decompression_algorithm = "gz"
}

resource "proxmox_virtual_environment_vm" "worker-nodes" {
    count = var.worker_nodes
    name = "worker-node-${format("%02d", count.index)}"
    description = "Managed by Terraform"
    tags = ["terraform", "worker"]
    node_name = var.node_name

    operating_system {
        type = "l26"
    }

    agent {
        enabled = true
    }

    cpu {
        cores = var.worker_nodes_cores
        type = "x86-64-v2-AES"
    }

    memory {
        dedicated = var.worker_nodes_ram_size
    }

    disk {
        datastore_id = var.vm_datastore_id
        discard = "on"
        iothread = true
        file_format = "raw"
        file_id = proxmox_virtual_environment_download_file.talos_linux_image.id
        interface = "virtio0"
        size = var.worker_nodes_disk_size
    }

    network_device {
        bridge = var.network_bridge_device
    }

    initialization {
        datastore_id = var.vm_datastore_id
        dns {
            servers = var.dns_servers
        }
        ip_config {
            ipv4 {
                address = "${cidrhost(var.worker_nodes_ipv4_prefix, count.index)}/32"
                gateway = var.ipv4_gateway
            }
        }

    }
}

resource "proxmox_virtual_environment_vm" "control-nodes" {
    count = var.control_nodes
    name = "control-node-${format("%02d", count.index)}"
    description = "Managed by Terraform"
    tags = ["terraform", "control"]
    node_name = var.node_name

    operating_system {
        type = "l26"
    }

    agent {
        enabled = true
    }

    cpu {
        cores = var.control_nodes_cores
        type = "x86-64-v2-AES"
    }

    memory {
        dedicated = var.control_nodes_ram_size
    }

    disk {
        datastore_id = var.vm_datastore_id
        discard = "on"
        iothread = true
        file_format = "raw"
        file_id = proxmox_virtual_environment_download_file.talos_linux_image.id
        interface = "virtio0"
        size = var.control_nodes_disk_size
    }

    network_device {
        bridge = var.network_bridge_device
    }

    initialization {
        datastore_id = var.vm_datastore_id
        dns {
            servers = var.dns_servers
        }
        ip_config {
            ipv4 {
                address = "${cidrhost(var.control_nodes_ipv4_prefix, count.index)}/32"
                gateway = var.ipv4_gateway
            }
        }

    }
}