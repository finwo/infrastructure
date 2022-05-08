datacenter = "${DATACENTER}"
data_dir = "/opt/consul/data"
client_addr = "127.0.0.1 {{ GetInterfaceIP \"docker0\" }}"
server = false

ui_config{
  enabled = false
}

bind_addr = "0.0.0.0" # Listen on all IPv4


retry_join = ["${NM_AGENT}"]
