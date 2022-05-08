# Setup data dir
data_dir = "/opt/nomad/data"
datacenter = "${DATACENTER}"

# Enable the client
client {
    enabled = true
    servers = ["${NM_AGENT}"]
}
plugin "raw_exec" {
  config {
    enabled = true
  }
}
plugin "docker" {
  config {
    auth {
      config = "/root/.docker/config.json"
    }
    volumes {
      enabled = true
    }
  }
}
