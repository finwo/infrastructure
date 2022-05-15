job "syncthing" {
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
      port "http" { to = 8384 }
    }

    task "task" {
      driver = "docker"

      config {
        image = "linuxserver/syncthing:latest"
        ports = ["http"]
        volumes = [
          "/mnt/pool/nomad/syncthing/config:/config",
          "/mnt/pool/nomad/syncthing/data:/data",
        ]
      }

      logs {
        max_files     = 10
        max_file_size = 15
      }

      kill_timeout = "60s"
      resources {
        cpu        =  200
        memory     =  512
      }

      service {
        name = "syncthing-eu-west1-b-finwo-net"
        tags = ["urlprefix-syncthing.eu-west1-b.finwo.net/"]
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
