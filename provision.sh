#!/bin/sh

set -eu

yum -y install\
 httpd\
 mysql mysql-server mysql-devel\
 memcached\
 perl perl-core\
 gcc\
 openssl-devel\
 perl-GD gd-devel\
 ImageMagick-perl\
 giflib-devel\
 netpbm-progs\
 gmp-devel\
 expat-devel perl-XML-Parser\
 libxml2-devel\
 zip unzip\
 wget

if [ ! -e /usr/local/bin/cpanm ]; then
  wget -O - https://cpanmin.us | perl - App::cpanminus
fi
if [ ! -L /usr/bin/cpanm ]; then
  ln -s /usr/local/bin/cpanm /usr/bin/
fi
cpanm -nq App::cpm
if [ ! -L /usr/bin/cpm ]; then
  ln -s /usr/local/bin/cpm /usr/bin/
fi

cpm install -g\
 Math::BigInt@1.9993\
 Archive::Tar\
 LWP::Protocol::https\
 Term::ReadKey

yum -y install\
 epel-release
yum -y install\
  aspell-en aspell-devel

cpm install -g Twiggy

yum -y install\
 php php-mysql php-gd php-pecl-memcache
sed 's/^;date\.timezone =/date\.timezone = "Asia\/Tokyo"/' -i /etc/php.ini

if [ ! -e /usr/local/bin/phpunit ]; then
  yum -y install\
   php-xml
  wget -O phpunit https://phar.phpunit.de/phpunit-old.phar
  chmod +x phpunit
  mv phpunit /usr/local/bin/
fi

chkconfig mysqld on
service mysqld start & sleep 10
mysql -e "create database if not exists mt_test default character set utf8;"
mysql -e "grant all privileges on mt_test.* to mt@localhost;"

cpm install -g Net::LDAP
yum -y install\
 openldap-clients openldap-servers
mkdir -p /var/lib/ldap/jp
chown ldap:ldap /var/lib/ldap/jp

wget -N https://raw.githubusercontent.com/movabletype/movabletype/develop/t/ldif/cn=config.ldif
wget -N https://raw.githubusercontent.com/movabletype/movabletype/develop/t/ldif/example_com.ldif
wget -N https://raw.githubusercontent.com/movabletype/movabletype/develop/t/ldif/example_jp.ldif
wget -N https://raw.githubusercontent.com/movabletype/movabletype/develop/t/ldif/domain1_example_jp.ldif
wget -N https://raw.githubusercontent.com/movabletype/movabletype/develop/t/ldif/domain2_example_jp.ldif

chkconfig slapd on
service slapd start & sleep 10
ldapmodify -Y EXTERNAL -H ldapi:// -f cn=config.ldif
ldapadd -f example_com.ldif -x -D "cn=admin,dc=example,dc=com" -w secret
ldapadd -f example_jp.ldif -x -D "cn=admin,dc=example,dc=jp" -w secret
ldapadd -f domain1_example_jp.ldif -x -D "cn=admin,dc=example,dc=jp" -w secret
ldapadd -f domain2_example_jp.ldif -x -D "cn=admin,dc=example,dc=jp" -w secret

yum -y install\
 npm tar bzip2 openssl-devel freetype-devel fontconfig-devel libicu-devel sqlite-devel libpng-devel libjpeg-devel
npm install -g phantomjs@1.9.20

wget -N https://raw.githubusercontent.com/movabletype/movabletype/develop/t/cpanfile
cpm install -g

cpm install -g JavaScript::Minifier CSS::Minifier
yum -y install git

