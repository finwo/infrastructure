datacenter  = "europe-west1-b"
data_dir    = "/opt/consul/data"
bind_addr   = "0.0.0.0"
client_addr = "127.0.0.1 {{GetInterfaceIP \"docker0\"}}"
retry_join  = ["10.164.0.10"]
ports {
}
addresses {
}
ui = false
server = false
