#!/usr/bin/env bash
terraform init
terraform validate
terraform apply -var-file terraform.tfvars
terraform output -raw talosconfig > talosconfig
terraform output -raw kubeconfig > .kube/config
