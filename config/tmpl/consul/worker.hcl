datacenter = "${DATACENTER}"
data_dir = "/opt/consul/data"
client_addr = "0.0.0.0"
server = false

ui_config{
  enabled = true
}

bind_addr = "0.0.0.0" # Listen on all IPv4
advertise_addr = "${NM_AGENT}"
