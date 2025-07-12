# About
This just covers the configuration files used to spin up my test Kubernetes cluster on Proxmox.

Documentation about the process is found on my personal website. [Link](https://stevenchen.one/) [Repo](https://github.com/Altereno/Personal-Website)

# Configuration
- Runs a Kubernetes cluster on Talos Linux
- Uses Cilium and Longhorn
- Configures a bare metal load balancer
- Sets up a Gateway with a wildcard certificate using GatewayAPI and Cert-Manager