job "fabio" {
  datacenters = ["eu-west1-b"]
  type = "system"

  group "fabio" {

    task "fabio" {
      driver = "exec"
      config {
        command = "fabio-1.6.0-linux_amd64"
        args = ["-proxy.addr", "$${attr.unique.network.ip-address}:80", "-registry.consul.addr", "127.0.0.1:8500", "-ui.addr", "$${attr.unique.network.ip-address}:9998"]
      }

      artifact {
        source = "https://github.com/fabiolb/fabio/releases/download/v1.6.0/fabio-1.6.0-linux_amd64"
      }

      resources {
        cpu    = 200
        memory = 128
      }
    }
  }
}
