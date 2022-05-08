#!/usr/bin/env bash

apt-get update
apt-get install -yqq docker.io

export DOCKERHUB_USERNAME=$(curl -fsSL "http://metadata.google.internal/computeMetadata/v1/instance/attributes/dockerhub-username" -H "Metadata-Flavor: Google")
export DOCKERHUB_PASSWORD=$(curl -fsSL "http://metadata.google.internal/computeMetadata/v1/instance/attributes/dockerhub-password" -H "Metadata-Flavor: Google")
echo ${DOCKERHUB_PASSWORD} | docker login --username ${DOCKERHUB_USERNAME} --password-stdin

systemctl enable docker
systemctl restart docker
