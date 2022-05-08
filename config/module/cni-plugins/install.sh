#!/usr/bin/env bash

mkdir -p /opt/cni/bin
wget https://github.com/containernetworking/plugins/releases/download/v0.8.2/cni-plugins-linux-amd64-v0.8.2.tgz -o /opt/cni/bin/cni-plugins.tgz
cd /opt/cni/bin
tar xvf cni-plugins.tgz
