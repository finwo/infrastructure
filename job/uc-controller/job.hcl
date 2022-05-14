job "uc-finwo-net" {
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
  group "uc-finwo-net-grp" {
    count = 1
    network {
      port "uc1900"  { static =  1900 }
      port "uc3478"  { static =  3478 }
      port "uc5514"  { static =  5514 }
      port "uc6789"  { static =  6789 }
      port "http"    { static =  8080 }
      port "https"   { static =  8443 }
      port "uc8880"  { static =  8880 }
      port "uc10001" { static = 10001 }
    }
    reschedule {
      delay          = "30s"
      delay_function = "constant"
      unlimited      = true
    }
    service {
      name = "web"
      tags = ["urlprefix-uc.finwo.net/"]
      port = "http"
      check {
        name     = "alive"
        type     = "http"
        interval = "10s"
        timeout  = "3s"
        path     = "/"
      }
    }
    task "uc-finwo-net-task" {
      driver = "docker"
      config {
        network_mode = "bridge"
        image = "linuxserver/unifi-controller"
        ports = ["uc1900", "uc3478", "uc5514", "uc6789", "http", "https", "uc8880", "uc10001"]
	volumes = [
          "/mnt/pool/nomad/unifi-controller:/config",
	]
      }
      logs {
        max_files     = 10
        max_file_size = 15
      }
      kill_timeout = "10s"
      resources {
        cpu        =  300
        memory     = 1024
        memory_max = 2048
      }
    }
  }
}
