#!/bin/sh

PWD=pwd

# Install software
yum install -y make glibc-devel gcc
yum install -y libexif-devel libjpeg-devel gd-devel curl-devel openssl-devel libxml2-devel pecl

# Download PHP source
cd /tmp
rm php -rf
wget -O - http://ro1.php.net/get/php-7.0.2.tar.gz/from/this/mirror | tar -xzp
mv php-*.*.*/ php

# Download imagick source
cd /tmp/php/ext
wget -O - https://pecl.php.net/get/imagick-3.4.0RC5.tgz | tar -xzp
mv imagick-*.*.*/ imagick

# Rebuild PHP config
cd /tmp/php
rm configure
./buildconf --force

# Configure PHP
./configure --prefix=/tmp/php/compiled/ \
	--without-pear	\
	--enable-shared=no	\
	--enable-static=yes	\
	--enable-phar	\
	--enable-json	\
	\
	--disable-all	\
	--with-openssl	\
	--with-curl	\
	\
	--enable-libxml	\
	--enable-simplexml	\
	--enable-xml	\
	\
	--with-mhash	\
	\
	--with-gd	\
	--with-imagick \
	--enable-exif	\
	--with-freetype-dir	\
	\
	--enable-mbstring	\
	\
	--enable-sockets

# Build PHP
make
make install

cd $PWD
cp /tmp/php/compiled/bin/php .
