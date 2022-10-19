#! /usr/bin/env bash

set -euo pipefail
IFS=$'\t\n'

# https://discuss.linuxcontainers.org/t/whats-the-deal-with-etc-default-lxd-bridge-upgraded/330/3


export DEBIAN_FRONTEND=noninteractive
apt-get update --yes --quiet
# apt-get upgrade --yes --quiet

# Upgrade and setup LXD

# apt-get install --yes --quiet --target-release=xenial-backports lxd

apt-get install --yes --quiet lxd

lxd init --auto
lxc network show lxdbr0
lxc network delete --force lxdbr0
lxc network create lxdbr0 \
  ipv4.address=auto \
  ipv4.nat=true \
  ipv6.address=auto \
  ipv6.nat=true
lxc network attach-profile lxdbr0 default

# Install and setup dnsmasq
apt-get install --yes --quiet dnsmasq

lxd_bridge="lxdbr0"
lxd_ipv4_addr="$(
  lxc network get "${lxd_bridge}" ipv4.address |
  cut \
    --delimiter='/' \
    --fields=1
)"
# Create dnsmasq configuration from template
echo "
# Tell any system-wide dnsmasq instance to make sure to bind to interfaces
# instead of listening on 0.0.0.0
# WARNING: changes to this file will get lost if lxd is removed.
server=/lxd/${lxd_ipv4_addr}
bind-interfaces
except-interface=${lxd_bridge}
" > /etc/dnsmasq.d/lxd

systemctl restart dnsmasq.service
