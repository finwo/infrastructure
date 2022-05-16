job "uptime-kuma" {
  datacenters = ["eu-west1-b"]
  type = "service"

  constraint {
    attribute = "${attr.kernel.name}"
    value     = "linux"
  }

  update {
    stagger      = "10s"
    max_parallel = 1
  }

  group "group" {
    count = 1

    network {
      port "http" { to = 3001 }
    }

    task "task" {
      driver = "docker"

      config {
        image = "louislam/uptime-kuma:latest"
        ports = ["http"]
        volumes = [
          "/mnt/pool/nomad/uptime-kuma:/app/data",
        ]
      }

      logs {
        max_files     = 10
        max_file_size = 15
      }

      kill_timeout = "60s"
      resources {
        cpu        =  100
        memory     =  256
      }

      service {
        name = "uptime-kuma-eu-west1-b-finwo-net"
        tags = ["urlprefix-uptime.finwo.net/"]
        port = "http"
        check {
          name     = "alive"
          type     = "http"
          interval = "10s"
          timeout  = "3s"
          path     = "/"
        }
      }
    }
  }
}
