#!/bin/bash

git clone --depth 10 https://github.com/robertdebock/docker-ubuntu-systemd.git
cd docker-ubuntu-systemd

docker build -t taylorm/ubuntu .

docker run --detach --name myubuntu -v $(pwd):/tmp/src --rm --tty --privileged --volume /sys/fs/cgroup:/sys/fs/cgroup:ro taylorm/ubuntu
