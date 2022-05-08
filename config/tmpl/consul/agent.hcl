datacenter = "${DATACENTER}"
data_dir = "/opt/consul/data"
client_addr = "127.0.0.1 {{ GetInterfaceIP \"docker0\" }}"
server = true

ui_config{
  enabled = true
}

bind_addr = "0.0.0.0" # Listen on all IPv4
advertise_addr = "${NM_AGENT}"

bootstrap_expect=1
