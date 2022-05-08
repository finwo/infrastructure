job "fabio" {
  datacenters = ["eu-west1-b"]
  type = "system"

  group "fabio" {

    task "fabio" {
      driver = "exec"
      config {
        command = "fabio-1.5.15-go1.15.5-linux_amd64"
        args = ["-proxy.addr", "$${attr.unique.network.ip-address}:9999", "-registry.consul.addr", "$${attr.unique.network.ip-address}:8500", "-ui.addr", "$${attr.unique.network.ip-address}:9998"]
      }

      artifact {
        source = "https://github.com/fabiolb/fabio/releases/download/v1.5.15/fabio-1.5.15-go1.15.5-linux_amd64"
      }

      resources {
        cpu    = 200
        memory = 128
      }
    }
  }
}
