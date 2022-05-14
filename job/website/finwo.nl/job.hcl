job "finwo-nl" {
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
  group "finwo-nl" {
    count = 1
    network {
      port "http" { to = 80 }
    }
    reschedule {
      delay          = "30s"
      delay_function = "constant"
      unlimited      = true
    }
    task "finwo-nl" {
      driver = "docker"
      config {
        image = "finwo/website"
        ports = ["http"]
      }
      service {
        name = "web"
        tags = ["urlprefix-finwo.nl/"]
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
        memory_max = 300
      }
    }
  }
}
