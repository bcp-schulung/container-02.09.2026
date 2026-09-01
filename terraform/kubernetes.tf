terraform {
  required_version = ">= 1.9.0"
}

module "kubernetes" {
  source  = "hcloud-k8s/kubernetes/hcloud"
  version = "5.6.1"

  cluster_name = "k8s"
  hcloud_token = var.hcloud_token

  # Export configs for talosctl and kubectl (optional)
  cluster_kubeconfig_path  = "kubeconfig"
  cluster_talosconfig_path = "talosconfig"

  # Enable Cilium Gateway API and Cert Manager (optional)
  cert_manager_enabled       = true
  cilium_gateway_api_enabled = true

  # Open Kube API and Talos API to the world so students can reach the cluster from their own VMs
  firewall_api_source = ["0.0.0.0/0", "::/0"]

  control_plane_nodepools = [
    { name = "control", type = "cpx22", location = "nbg1", count = 3 }
  ]
  worker_nodepools = [
    { name = "worker", type = "cpx22", location = "nbg1", count = 3 }
  ]
}
