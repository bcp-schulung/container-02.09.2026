output "control_plane_public_ipv4_list" {
  value = module.kubernetes.control_plane_public_ipv4_list
}

output "worker_public_ipv4_list" {
  value = module.kubernetes.worker_public_ipv4_list
}
