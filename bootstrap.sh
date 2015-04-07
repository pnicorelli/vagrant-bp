#!/usr/bin/env bash
DBPASSWD=root

sudo su

echo -e "\n--- System Install ---\n"
add-apt-repository -y ppa:opencpu/rapache

apt-get update > /dev/null 2>&1
apt-get install debconf-utils > /dev/null 2>&1

echo -e "\n--- Install Services ---\n"
apt-get -y install apache2 libapache2-mod-r-base > /dev/null 2>&1
apt-get -y install r-base-dev

if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi



echo -e "\n--- Enabling mod-rewrite ---\n"
a2enmod rewrite > /dev/null 2>&1

echo -e "\n--- Allowing Apache override to all ---\n"
sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf

echo -e "\n--- Install Utilities ---\n"
apt-get -y install vim curl build-essential git > /dev/null 2>&1
