job "git-finwo-net" {
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
  group "git-finwo-net-grp" {
    count = 1
    network {
      port "http" { to = 5000 }
    }
    reschedule {
      delay          = "30s"
      delay_function = "constant"
      unlimited      = true
    }
    task "git-finwo-net-task" {
      driver = "docker"

      config {
        image = "finwo/quark"
        ports = ["http"]
        volumes = [
          "/mnt/pool/nomad/git-webroot:/srv/www",
        ]
      }

      service {
        name = "git-finwo-net"
        tags = ["urlprefix-git.finwo.net/"]
        port = "http"
        check {
          name     = "alive"
          type     = "http"
          interval = "10s"
          timeout  = "3s"
          path     = "/"
        }
      }

      logs {
        max_files     = 10
        max_file_size = 15
      }
      kill_timeout = "10s"
      resources {
        cpu        = 100
        memory     = 100
      }
    }
  }
}
