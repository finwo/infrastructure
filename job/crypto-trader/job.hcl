job "crypto-trader" {
  datacenters = ["eu-west1-b"]
  type = "batch"

  constraint {
    attribute = "${attr.kernel.name}"
    value     = "linux"
  }

  periodic {
    cron             = "0 * * * *" # Each hour, on the hour
    prohibit_overlap = true
    time_zone        = "Europe/Amsterdam"
  }

  group "cronjob" {
    count = 1

    task "crypto-trader-task" {
      driver = "docker"

      config {
        image = "finwo/crypto-trader-cronjob:latest"
        volumes = [
          "/mnt/pool/nomad/crypto-trader:/data",
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

    }
  }
}
