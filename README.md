# vagrant-mt-dev
Vagrantfile for building environment that can run/develop MT.

### Vagrant Box built by this Vagrantfile
* Name
  * masahiroiuchi/mt-dev
* Page on Vagrant Cloud
  * [https://app.vagrantup.com/masahiroiuchi/boxes/mt-dev]()

# What you can do on this Vagrant Box
* To run MT
* To run MT in shared directory
* To use dynamic publishing
* To use 4 image drivers
  * GD
  * ImageMagick
  * Imager
  * NetPBM
* To run MT tests
* To build MT
* To build Riot.js files
* To build a-table.js

## Requirements to use this Vagrant Box
* VirtualBox
* Vagrant
  * vagrant-hostmanager

## Usage of this Vagrant Box
```bash
$ wget https://raw.githubusercontent.com/masiuchi/vagrant-mt-dev/master/Vagrantfile
$ vagrant plugin install vagrant-hostmanager
$ vagrant up
$ open http://mt-dev.test
```

## Information of this Vagrant Box in detail

### Intalled softwares
* Ubuntu 12.04.5 LTS
* Apache HTTP Server 2.2.22
  * Both user and group of this process are "vagrant" to manipulate file/directory in /vagrant directory.
* MySQL 5.5.54
* Memcached 1.4.13
* Perl 5.14.2
  * App::cpm
  * Cache::File
  * Image::Magick 6.6.9
  * CPAN modules in cpanfile of MT develop branch
* PHP 5.3.10
  * mysql module
  * mysqli module
  * pdo_mysql module
  * memcache module
  * gd module
  * PHPUnit 4.8.36
  * phpMyAdmin 3.4.10.1deb1
* PhantomJS 1.9.8
* Node.js 4.8.3
  * Yarn
* git 1.7.9.5

### Site map
* http://mt-dev.test
  * /var/www
  * Both CGI(Perl) and PHP work
* http://mt-dev.test/shared
  * /var/www/shared
  * Symbolic link of /vagrant/shared
  * Both CGI(Perl) and PHP work
* http://mt-dev.test/phpmyadmin
  * phpMyAdmin

### Directory map
* /vagrant
  * Synced Folder by Vagrant
* /vagrant/shared
  * Symbolic linked to /var/www/shared
* /var/www
  * Site root of httpd

