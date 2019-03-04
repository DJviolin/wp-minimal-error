#!/bin/bash

set -e

################################################################################
# Common packages
################################################################################

apt update
apt upgrade -y

apt install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg2 \
	software-properties-common

echo -e "\n\ncd /vagrant" >> /home/vagrant/.bashrc

################################################################################
# Adding repositories
################################################################################

# Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
#apt-key fingerprint 0EBFCD88
add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/debian \
	$(lsb_release -cs) \
	stable"

apt update

################################################################################
# Install Docker
################################################################################

# https://aboutsimon.com/blog/2018/04/18/Ubuntu-Docker-Version-Pinning-for-Kubernetes.html
# Pin: version 18.06.*
cat <<EOF > /etc/apt/preferences.d/docker
Package: docker-ce
Pin: version 18.06.0*
Pin-Priority: 1000
EOF

apt install -y \
	docker-ce

curl -sL "https://github.com/docker/compose/releases/download/1.24.0-rc1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# https://docs.docker.com/install/linux/linux-postinstall/
#groupadd docker
usermod -aG docker vagrant

################################################################################
# unattended-upgrades fix without disabling
# apt update disabled right after boot
# https://github.com/geerlingguy/packer-ubuntu-1604/issues/3#issuecomment-219257091
# https://www.vagrantup.com/docs/boxes/base.html
# https://www.vagrantup.com/docs/virtualbox/boxes.html
# https://github.com/QubesOS/qubes-issues/issues/2621
################################################################################

apt purge -y \
	unattended-upgrades \
	apt-listchanges

apt autoremove -y
