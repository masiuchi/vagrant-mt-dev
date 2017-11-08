#!/bin/sh

CPM_WORKERS=5

set -eu

apt-get update

# php
apt-get -y --no-install-recommends install\
 php5 php5-cli php5-mysql php5-gd php5-memcache
if [ ! `which phpunit` ]; then
  wget -O phpunit https://phar.phpunit.de/phpunit-old.phar
  chmod +x phpunit
  mv phpunit /usr/local/bin/
fi

# apache2
apt-get -y --no-install-recommends install\
 apache2

# mysql
DEBIAN_FRONTEND=nointeractive\
 apt-get -y --no-install-recommends install\
 mysql-server mysql-client

# memcached
apt-get -y install --no-install-recommends\
 memcached

# mt required modules
if [ ! `which cpm` ]; then
  curl -sL --compressed https://git.io/cpm > /usr/local/bin/cpm
  chmod +x /usr/local/bin/cpm
fi

apt-get -y --no-install-recommends install\
 make gcc pkg-config libssl-dev libxml2-dev libexpat1-dev\
 perlmagick netpbm libgd2-xpm-dev libpng12-dev libgif-dev libjpeg-dev
wget -N https://raw.githubusercontent.com/movabletype/movabletype/develop/t/cpanfile
cpm install -g -w $CPM_WORKERS --test --without-test

cpm install -g -w $CPM_WORKERS --test Cache::File

# mt test modules
if [ ! `which phantomjs` ]; then
  wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2
  tar jxf phantomjs-1.9.8-linux-x86_64.tar.bz2
  cp phantomjs-1.9.8-linux-x86_64/bin/phantomjs /usr/local/bin/
fi
apt-get -y --no-install-recommends install\
 libgmp-dev
cpm install -g -w $CPM_WORKERS --test JSON::XS Test::Base YAML
cpm install -g -w $CPM_WORKERS --test

# mt build modules
cpm install -g -w $CPM_WORKERS --test JavaScript::Minifier CSS::Minifier

# nodejs
curl -sL https://deb.nodesource.com/setup_4.x | bash -
apt-get -y --no-install-recommends install\
 nodejs
npm install yarn -g

# phpmyadmin
DEBIAN_FRONTEND=nointeractive\
 apt-get -y --no-install-recommends install\
 phpmyadmin

# files
cp -rf /vagrant/files/* /

# shared directory settings
a2ensite shared
service apache2 reload

# /var/www/ owner and group
chown -R vagrant:vagrant /var/www

# test database
mysql -e "create database if not exists mt_test character set utf8"
mysql -e "grant all privileges on mt_test.* to mt@localhost"

# phpmyadmin settings
if [ ! -L /etc/apache2/sites-available/phpmyadmin ]; then
  ln -s /etc/phpmyadmin/apache.conf /etc/apache2/sites-available/phpmyadmin
  a2ensite phpmyadmin
  service apache2 reload
fi

# tools
apt-get -y --no-install-recommends install\
 git

# clean up
apt-get clean
rm -rf\
 /var/cache/apt/archives/*\
 /var/lib/apt/lists/*\
 /root/.qws\
 /root/.cpanm\
 /root/.perl-cpm\
 /root/.npm\
 /home/vagrant/*

