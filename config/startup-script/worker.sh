#!/usr/bin/env bash

function module {
  curl -fsSL https://raw.githubusercontent.com/finwo/infrastructure/master/config/module/$1 | bash
}

function tmpl {
  curl -fsSL https://raw.githubusercontent.com/finwo/infrastructure/master/config/tmpl/$1 | envsubst
}

module docker/install.sh
module consul/install.sh
module nomad/install.sh
module cni-plugins/install.sh

export DATACENTER=$(curl -fsSL "http://metadata.google.internal/computeMetadata/v1/instance/attributes/datacenter" -H "Metadata-Flavor: Google")
export NM_AGENT=$(curl -fsSL "http://metadata.google.internal/computeMetadata/v1/instance/attributes/nm-agent" -H "Metadata-Flavor: Google")

mkdir -p /etc/nomad.d
mkdir -p /opt/nomad/data
tmpl nomad/worker.hcl > /etc/nomad.d/nomad.hcl
tmpl consul/worker.hcl > /etc/consul.d/consul.hcl

module consul/enable.sh
module nomad/enable.sh
