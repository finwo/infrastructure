# Setup data dir
data_dir = "/opt/nomad/data"
datacenter = "${DATACENTER}"

# Registration in the service mesh
consul {

  # Where to register
  address = "localhost:8500"

  # What to register as
  server_service_name = "nomad"
  # client_service_name = "nomad-client"

  # Enable service registration
  auto_advertise = true

  # Bootstrap server and client using consul
  server_auto_join = true
  # client_auto_join = true
}

server {
  enabled = true
}
client {
  enabled = false
}
