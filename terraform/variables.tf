variable "hcloud_token" {
  description = "Hetzner Cloud API token (set via TF_VAR_hcloud_token env var, not committed)"
  type        = string
  sensitive   = true
}
