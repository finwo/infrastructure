job "plex-finwo-net" {
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
  group "plex-finwo-net-grp" {
    count = 1
    network {
      port "http" { to = 32400 }
    }
    reschedule {
      delay          = "30s"
      delay_function = "constant"
      unlimited      = true
    }
    task "plex-finwo-net-task" {
      driver = "docker"
      config {
        image = "linuxserver/plex"
        ports = ["http"]
        volumes = [
          "/mnt/pool/nomad/plex/config:/config",
          "/mnt/pool/nomad/plex/data:/data"
        ]
      }

      service {
        name = "plex-finwo-net"
        tags = ["urlprefix-plex.finwo.net/"]
        port = "http"
        check {
          name     = "alive"
          type     = "http"
          interval = "10s"
          timeout  = "3s"
          path     = "/web/index.html"
        }
      }

      logs {
        max_files     = 10
        max_file_size = 15
      }
      kill_timeout = "10s"
      resources {
        cpu        = 3500
        memory     =  768
        memory_max = 2048
      }
    }
  }
}
