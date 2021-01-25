#!/usr/bin/env bash

apt-get update

apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
		openvpn \
		git \
		build-essential \
		openvpn-systemd-resolved -y


curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
curl -sL https://deb.nodesource.com/setup_15.x | bash -

apt-get update

apt-get install nodejs yarn -y

apt-get install docker docker-compose -y

usermod -aG docker vagrant

useradd -m -s /usr/bin/bash -p $(openssl passwd -1 asdf1234) jevgeni

usermod -aG docker jevgeni

echo 'jevgeni ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/jevgeni

mkdir /home/jevgeni/.ssh
mkdir /home/jevgeni/vpn

cp -r /vagrant/.ssh/* /home/jevgeni/.ssh/
cp -r /vagrant/vpn/* /home/jevgeni/vpn/


cat /home/jevgeni/.ssh/id_rsa.pub >> /home/jevgeni/.ssh/authorized_keys

chmod 600 /home/jevgeni/.ssh/id_rsa
chmod 600 /home/jevgeni/.ssh/uxp.pem
chmod 600 /home/jevgeni/.ssh/config
chmod 644 /home/jevgeni/.ssh/id_rsa.pub
chmod 644 /home/jevgeni/.ssh/authorized_keys

chown -R jevgeni:jevgeni /home/jevgeni
chown -R jevgeni:jevgeni /home/jevgeni/*

su - jevgeni

git clone git@github.com:mudcrab/dot.git /home/jevgeni/.dot

echo 'source ~/.dot/shell/bashrc' >> /home/jevgeni/.bashrc

ln -s /home/jevgeni/.dot/.tmux.conf /home/jevgeni/.tmux.conf
ln -s /home/jevgeni/.dot/.gitconfig /home/jevgeni/.gitconfig
