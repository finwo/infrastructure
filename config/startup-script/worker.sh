#!/usr/bin/env bash

function module {
  curl -fsSL https://raw.githubusercontent.com/finwo/infrastructure/master/config/module/$1 | bash
}

function tmpl {
  curl -fsSL https://raw.githubusercontent.com/finwo/infrastructure/master/config/tmpl/$1 | envsubst
}

export DEFAULT_IFACE=$(ip route | grep default | tr ' ' '\n' | grep dev -A 1 | tail -1)
export DEFAULT_IP=$(ip route | grep default | tr ' ' '\n' | grep src -A 1 | tail -1)
export DATACENTER=$(curl -fsSL "http://metadata.google.internal/computeMetadata/v1/instance/attributes/datacenter" -H "Metadata-Flavor: Google")
export NM_AGENT=$(curl -fsSL "http://metadata.google.internal/computeMetadata/v1/instance/attributes/nm-agent" -H "Metadata-Flavor: Google")
export NFS_AGENT=$(curl -fsSL "http://metadata.google.internal/computeMetadata/v1/instance/attributes/nfs-agent" -H "Metadata-Flavor: Google")

module socat/install.sh
module docker/install.sh
module consul/install.sh
module nomad/install.sh
module cni-plugins/install.sh
module nfs-client/install.sh

mkdir -p /etc/nomad.d
mkdir -p /opt/nomad/data
tmpl nomad/worker.hcl > /etc/nomad.d/nomad.hcl
tmpl consul/worker.hcl > /etc/consul.d/consul.hcl

module consul/enable.sh
module nomad/enable.sh

# Google's loadbalancer routing is funky and incompatible with docker's port mapping
iptables -t nat -A PREROUTING -i ${DEFAULT_IFACE} -j DNAT --to-destination ${DEFAULT_IP}
