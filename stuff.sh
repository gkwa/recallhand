#!/bin/bash

apt -qq update
apt -qy install iputils-ping
ping -c 10 google.com
apt -qy install apache2
systemctl status apache2
systemctl enable apache2
systemctl start apache2
systemctl status apache2
