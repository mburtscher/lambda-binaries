#!/bin/sh

PWD=pwd

# Install software
sudo yum groupinstall "Development Tools"

# Download PhantomJS source
cd /tmp
rm phantomjs -rf
git clone https://github.com/ariya/phantomjs.git

# Build PhantomJS
cd phantomjs
./build.py -c


exit

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
