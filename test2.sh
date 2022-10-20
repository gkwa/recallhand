#!/bin/bash

git clone https://github.com/robertdebock/docker-ubuntu-systemd.git
cd docker-ubuntu-systemd

docker build -t taylorm/ubuntu .

docker run --detach --name myubuntu --rm --tty --privileged --volume /sys/fs/cgroup:/sys/fs/cgroup:ro taylorm/ubuntu
sleep 5

docker exec myubuntu bash -c 'apt -qq update'
docker exec myubuntu bash -c 'apt -qy install iputils-ping'
docker exec myubuntu bash -c 'ping -c 10 google.com'
docker exec myubuntu bash -c 'apt -qy install apache2'
docker exec myubuntu bash -c 'systemctl status apache2'
docker exec myubuntu bash -c 'systemctl enable apache2'
docker exec myubuntu bash -c 'systemctl start apache2'
docker exec myubuntu bash -c 'systemctl status apache2'
