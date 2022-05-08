# Full configuration options can be found at https://www.nomadproject.io/docs/configuration

datacenter = "${datacenter}"
data_dir   = "/opt/nomad/data"
bind_addr  = "0.0.0.0"

server {
  # license_path is required as of Nomad v1.1.1+
  #license_path = "/etc/nomad.d/nomad.hcl"
  enabled = true
  bootstrap_expect = 1
}
client {
  enabled = false
}
