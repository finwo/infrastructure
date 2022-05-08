job "consul" {
  datacenters = ["eu-west1-b"]
  type = "system"

  group "consul" {
    network {
      port "lb" {
        static = 80
        to = 9999
      }
      port "ui" {
        static = 9998
      }
    }
    task "consul" {
      driver = "raw_exec"

      config {
        command = "local/bin/consul"
        args    = ["agent", "-config-file=local/etc/consul.d/consul.hcl"]
      }

      artifact {
        source      = "https://releases.hashicorp.com/consul/1.12.0/consul_1.12.0_linux_amd64.zip"
        destination = "local/bin"
      }

      artifact {
        source      = "https://raw.githubusercontent.com/finwo/infrastructure/master/job/consul-client/consul.hcl"
        destination = "local/etc/consul.d"
      }

      resources {
        cpu    = 200
        memory = 128
      }
    }
  }
}
