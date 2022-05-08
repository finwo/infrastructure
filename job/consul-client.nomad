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
    task "fabio" {
      driver = "raw_exec"

      config {
        command = "local/consul/consul"
        args    = ["agent", "-config-file=local/consul.hcl"]
      }

      artifact {
        source      = "https://releases.hashicorp.com/consul/1.12.0/consul_1.12.0_linux_amd64.zip"
        destination = "local/consul"
      }

      template {
        data = <<EOH
datacenter = "eu-west1-b"
data_dir = "/opt/consul/data"
client_addr = "127.0.0.1"
server = false
bind_addr = "127.0.0.1"
advertise_addr = "127.0.0.1"
retry_join = ["10.164.0.10"]
ui_config {
  enabled = false
}
EOH

        destnation = "local/consul.hcl"
      }

      resources {
        cpu    = 200
        memory = 128
      }
    }
  }
}
