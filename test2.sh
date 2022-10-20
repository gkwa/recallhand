#!/bin/bash

git clone https://github.com/robertdebock/docker-ubuntu-systemd.git
cd docker-ubuntu-systemd

docker run --name myubuntu --rm --tty --privileged --volume /sys/fs/cgroup:/sys/fs/cgroup:ro taylorm/ubuntu -d
sleep 5
docker exec myubuntu -- bash -c 'ping -c 10 google.com'
