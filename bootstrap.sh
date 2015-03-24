#!/usr/bin/env bash
DBPASSWD=root

echo -e "\n--- System Install ---\n"
apt-get update > /dev/null 2>&1
apt-get install debconf-utils > /dev/null 2>&1

echo 'mysql-server-5.5 mysql-server/root_password password '$DBPASSWD | debconf-set-selections
echo 'mysql-server-5.5 mysql-server/root_password_again password '$DBPASSWD | debconf-set-selections
echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password '$DBPASSWD | debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password '$DBPASSWD | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password '$DBPASSWD | debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections


echo -e "\n--- Install Services ---\n"
apt-get -y install mysql-server apache2 php5 libapache2-mod-php5 phpmyadmin > /dev/null 2>&1

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
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
